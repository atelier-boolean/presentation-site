import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:presentation_site/data/models/contact_message.dart';
import 'package:presentation_site/data/repos/contact_repository.dart';
import 'package:presentation_site/data/repos/contact_send_result.dart';

const ContactMessage _kMessage = ContactMessage(
  name: 'Ada',
  email: 'ada@example.com',
  message: 'I would like a new website.',
);
final Uri _kEndpoint = Uri.parse('https://example.com/api/contact');

/// A repository whose server always answers [status] with [body].
ContactRepository _answering(int status, [String body = '']) => ContactRepository(
  client: MockClient((http.Request request) async => http.Response(body, status)),
  endpoint: _kEndpoint,
);

void main() {
  group('send', () {
    test('posts the message as JSON', () async {
      // Arrange
      late http.Request sent;
      final ContactRepository repository = ContactRepository(
        client: MockClient((http.Request request) async {
          sent = request;
          return http.Response('{}', 200);
        }),
        endpoint: _kEndpoint,
      );

      // Act
      await repository.send(_kMessage);

      // Assert
      expect(
        <Object>[sent.method, sent.url, jsonDecode(sent.body) as Object],
        <Object>[
          'POST',
          _kEndpoint,
          _kMessage.toJson(),
        ],
      );
    });

    test('succeeds on a 200', () async {
      // Arrange
      final ContactRepository repository = _answering(200, '{}');

      // Act
      final ContactSendResult result = await repository.send(_kMessage);

      // Assert
      expect(result, isA<ContactSendSucceeded>());
    });

    test('returns the field errors of a 400', () async {
      // Arrange
      final ContactRepository repository = _answering(
        400,
        jsonEncode(<String, Object>{
          'errors': <String, Object>{'email': 'Bad email.', 'ignored': 1},
        }),
      );

      // Act
      final ContactSendResult result = await repository.send(_kMessage);

      // Assert
      expect(
        (result as ContactSendRejected).errors,
        <String, String>{'email': 'Bad email.'},
      );
    });

    test('fails as a server error on an unreadable 400', () async {
      // Arrange
      final ContactRepository repository = _answering(400, 'not json');

      // Act
      final ContactSendResult result = await repository.send(_kMessage);

      // Assert
      expect((result as ContactSendFailed).reason, ContactFailure.server);
    });

    test('fails as a server error on a 500', () async {
      // Arrange
      final ContactRepository repository = _answering(500);

      // Act
      final ContactSendResult result = await repository.send(_kMessage);

      // Assert
      expect((result as ContactSendFailed).reason, ContactFailure.server);
    });

    test('fails as a network error when the server cannot be reached', () async {
      // Arrange
      final ContactRepository repository = ContactRepository(
        client: MockClient(
          (http.Request request) => throw http.ClientException('offline'),
        ),
        endpoint: _kEndpoint,
      );

      // Act
      final ContactSendResult result = await repository.send(_kMessage);

      // Assert
      expect((result as ContactSendFailed).reason, ContactFailure.network);
    });
  });
}

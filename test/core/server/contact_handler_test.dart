import 'dart:convert';

import 'package:presentation_site/core/server/contact_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

final Uri _kUrl = Uri.parse('http://localhost/api/contact');
const Map<String, String> _kGood = <String, String>{
  'name': 'Ada',
  'email': 'ada@example.com',
  'message': 'I would like a new website.',
};

Request _json(Object body) => Request(
  'POST',
  _kUrl,
  body: jsonEncode(body),
  headers: <String, String>{'content-type': 'application/json'},
);

Request _form(Map<String, String> values) => Request(
  'POST',
  _kUrl,
  body: Uri(queryParameters: values).query,
  headers: <String, String>{'content-type': 'application/x-www-form-urlencoded'},
);

void main() {
  group('handleContact', () {
    test('answers 200 to a good JSON message', () async {
      // Arrange
      final Request request = _json(_kGood);

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(response.statusCode, 200);
    });

    test('answers 400 with each field error to a bad JSON message', () async {
      // Arrange
      final Request request = _json(<String, String>{..._kGood, 'email': 'nope'});

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(
        <Object>[
          response.statusCode,
          jsonDecode(await response.readAsString()) as Object,
        ],
        <Object>[
          400,
          <String, Object>{
            'errors': <String, String>{
              'email': 'Enter an email address, like name@example.com.',
            },
          },
        ],
      );
    });

    test('answers 400 to JSON that is not an object', () async {
      // Arrange
      final Request request = _json(<String>['not', 'an', 'object']);

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(response.statusCode, 400);
    });

    test('answers 400 to a body that is not JSON', () async {
      // Arrange
      final Request request = Request(
        'POST',
        _kUrl,
        body: '{broken',
        headers: <String, String>{'content-type': 'application/json'},
      );

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(response.statusCode, 400);
    });

    test('sends a good plain form back to the page as sent', () async {
      // Arrange
      final Request request = _form(_kGood);

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(
        <Object?>[response.statusCode, response.headers['location']],
        <Object?>[
          303,
          '/contact?sent=1',
        ],
      );
    });

    test('sends a bad plain form back to the page as invalid', () async {
      // Arrange
      final Request request = _form(<String, String>{..._kGood, 'name': ''});

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(response.headers['location'], '/contact?invalid=1');
    });

    test('answers 415 to any other content type', () async {
      // Arrange
      final Request request = Request(
        'POST',
        _kUrl,
        body: 'hello',
        headers: <String, String>{'content-type': 'text/plain'},
      );

      // Act
      final Response response = await handleContact(request);

      // Assert
      expect(response.statusCode, 415);
    });
  });
}

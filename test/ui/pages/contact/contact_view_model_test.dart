import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:presentation_site/data/repos/contact_repository.dart';
import 'package:presentation_site/data/repos/contact_send_result.dart';
import 'package:presentation_site/ui/pages/contact/contact_state.dart';
import 'package:presentation_site/ui/pages/contact/contact_view_model.dart';

const Map<String, String> _kValues = <String, String>{
  'name': 'Ada',
  'email': 'ada@example.com',
  'message': 'I would like a new website.',
};
final Uri _kEndpoint = Uri.parse('https://example.com/api/contact');

/// A view model whose server always answers [status] with [body].
ContactViewModel _answering(int status, [String body = '{}']) => ContactViewModel(
  repository: ContactRepository(
    client: MockClient((http.Request request) async => http.Response(body, status)),
    endpoint: _kEndpoint,
  ),
);

void main() {
  group('send', () {
    test('goes through sending to sent', () async {
      // Arrange
      final ContactViewModel viewModel = _answering(200);
      final List<ContactState> states = <ContactState>[];
      viewModel.stream.listen(states.add);

      // Act
      await viewModel.send(_kValues);
      await viewModel.close();

      // Assert
      expect(states, const <ContactState>[
        ContactEditing(),
        ContactSending(),
        ContactSent(),
      ]);
    });

    test('ends rejected with the server field errors', () async {
      // Arrange
      final ContactViewModel viewModel = _answering(
        400,
        jsonEncode(<String, Object>{
          'errors': <String, String>{'email': 'Bad email.'},
        }),
      );

      // Act
      await viewModel.send(_kValues);

      // Assert
      expect(
        viewModel.state,
        const ContactRejected(<String, String>{'email': 'Bad email.'}),
      );
    });

    test('ends failed when the server breaks', () async {
      // Arrange
      final ContactViewModel viewModel = _answering(500);

      // Act
      await viewModel.send(_kValues);

      // Assert
      expect(viewModel.state, const ContactFailed(ContactFailure.server));
    });

    test('ignores a second send while the first is on its way', () async {
      // Arrange
      int requests = 0;
      final ContactViewModel viewModel = ContactViewModel(
        repository: ContactRepository(
          client: MockClient((http.Request request) async {
            requests++;
            return http.Response('{}', 200);
          }),
          endpoint: _kEndpoint,
        ),
      );

      // Act
      await Future.wait(<Future<void>>[
        viewModel.send(_kValues),
        viewModel.send(_kValues),
      ]);

      // Assert
      expect(requests, 1);
    });

    test('emits nothing once closed while sending', () async {
      // Arrange
      final ContactViewModel viewModel = _answering(200);

      // Act
      final Future<void> sending = viewModel.send(_kValues);
      await viewModel.close();
      await sending;

      // Assert
      expect(viewModel.state, const ContactSending());
    });
  });

  group('edit', () {
    test('clears a rejection', () {
      // Arrange
      final ContactViewModel viewModel = ContactViewModel(
        repository: ContactRepository(
          client: MockClient((_) async => http.Response('', 200)),
        ),
        initial: const ContactRejected(<String, String>{}),
      );

      // Act
      viewModel.edit();

      // Assert
      expect(viewModel.state, const ContactEditing());
    });

    test('clears a failure', () {
      // Arrange
      final ContactViewModel viewModel = ContactViewModel(
        repository: ContactRepository(
          client: MockClient((_) async => http.Response('', 200)),
        ),
        initial: const ContactFailed(ContactFailure.network),
      );

      // Act
      viewModel.edit();

      // Assert
      expect(viewModel.state, const ContactEditing());
    });

    test('leaves a sent message alone', () {
      // Arrange
      final ContactViewModel viewModel = ContactViewModel(
        repository: ContactRepository(
          client: MockClient((_) async => http.Response('', 200)),
        ),
        initial: const ContactSent(),
      );

      // Act
      viewModel.edit();

      // Assert
      expect(viewModel.state, const ContactSent());
    });
  });
}

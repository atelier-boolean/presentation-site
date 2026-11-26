import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:presentation_site/core/network/http_status_codes.dart';
import 'package:presentation_site/data/models/contact_message.dart';
import 'package:presentation_site/data/repos/contact_send_result.dart';

/// Sends contact messages to the site's `/api/contact`.
///
/// The caller creates the [http.Client] and closes it, so tests can pass a fake one.
///
/// ```dart
/// final ContactSendResult result = await ContactRepository(client: client).send(message);
/// ```
final class ContactRepository {
  static const String _kPath = '/api/contact';
  static const String _kErrorsKey = 'errors';
  static const Map<String, String> _kJsonHeaders = <String, String>{
    'content-type': 'application/json',
  };

  final http.Client _client;
  final Uri _endpoint;

  /// [endpoint] defaults to `/api/contact` on the page's own site.
  ContactRepository({required http.Client client, Uri? endpoint})
    : _client = client,
      _endpoint = endpoint ?? Uri.base.resolve(_kPath);

  /// Sends [message] and says how it went. Never throws: every outcome is a result.
  Future<ContactSendResult> send(ContactMessage message) async {
    try {
      final http.Response response = await _client.post(
        _endpoint,
        headers: _kJsonHeaders,
        body: jsonEncode(message.toJson()),
      );
      return switch (response.statusCode) {
        final int code when HttpStatusCodes.isSuccess(code) =>
          const ContactSendSucceeded(),
        HttpStatusCodes.badRequest => _rejection(response.body),
        _ => const ContactSendFailed(.server),
      };
    } on http.ClientException {
      return const ContactSendFailed(.network);
    }
  }

  /// The field errors in a 400 answer, or a server failure when the body isn't readable.
  ContactSendResult _rejection(String body) {
    try {
      return switch (jsonDecode(body)) {
        {_kErrorsKey: final Map<String, Object?> errors} => ContactSendRejected(
          <String, String>{
            for (final MapEntry<String, Object?>(:String key, :Object? value)
                in errors.entries)
              if (value is String) key: value,
          },
        ),
        _ => const ContactSendFailed(.server),
      };
    } on FormatException {
      return const ContactSendFailed(.server);
    }
  }
}

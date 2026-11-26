import 'dart:convert';

import 'package:presentation_site/core/network/http_status_codes.dart';
import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/contact_rules.dart';
import 'package:presentation_site/data/models/contact_message.dart';
import 'package:shelf/shelf.dart';

const String _kJson = 'application/json';
const String _kForm = 'application/x-www-form-urlencoded';
const Map<String, String> _kJsonHeaders = <String, String>{'content-type': _kJson};

/// Receives a contact message on `POST /api/contact` and checks it with [ContactRules].
///
/// The page's code sends JSON and gets 200, or 400 with each field's error. Before that
/// code runs, the browser posts the plain form; it gets sent back to `/contact`, with
/// `?sent=1` or `?invalid=1`.
///
/// The message isn't sent or stored yet, and never logged: it holds personal data.
Future<Response> handleContact(Request request) async {
  final String body = await request.readAsString();
  return switch (request.mimeType) {
    _kJson => _answerJson(body),
    _kForm => _answerForm(body),
    _ => Response(HttpStatusCodes.unsupportedMediaType),
  };
}

Response _answerJson(String body) {
  try {
    return switch (jsonDecode(body)) {
      final Map<String, Object?> values => switch (_errorsIn(values)) {
        final Map<String, String> errors when errors.isEmpty => Response.ok(
          jsonEncode(<String, Object>{}),
          headers: _kJsonHeaders,
        ),
        final Map<String, String> errors => Response(
          HttpStatusCodes.badRequest,
          body: jsonEncode(<String, Object>{'errors': errors}),
          headers: _kJsonHeaders,
        ),
      },
      _ => Response(HttpStatusCodes.badRequest),
    };
  } on FormatException {
    return Response(HttpStatusCodes.badRequest);
  }
}

Response _answerForm(String body) {
  final String query = _errorsIn(Uri.splitQueryString(body)).isEmpty
      ? AppRoutes.contactSentQuery
      : AppRoutes.contactInvalidQuery;
  return Response.seeOther('${AppRoutes.contact}?$query=${AppRoutes.queryYes}');
}

Map<String, String> _errorsIn(Map<String, Object?> values) =>
    ContactRules.errorsOf(ContactMessage.fromMap(values));

import 'dart:io';

import 'package:shelf/shelf.dart';

const String _kGzip = 'gzip';

// Text types worth compressing; pictures and fonts come compressed already.
const List<String> _kCompressibleTypes = <String>[
  'text/',
  'application/javascript',
  'application/json',
  'image/svg+xml',
];

// Below this, gzip's own header outweighs what it saves.
const int _kMinBytes = 1024;

// Responses that never carry a body.
const List<int> _kBodilessStatuses = <int>[
  HttpStatus.noContent,
  HttpStatus.notModified,
];

/// Compresses text responses (pages, styles, scripts, JSON) with gzip when the browser
/// accepts it.
///
/// Shelf sends bodies as they are; pages carry all of the design system's CSS, which
/// gzip shrinks to a fraction. The body streams through the encoder, so nothing waits
/// for the whole response.
abstract final class GzipMiddleware {
  static Middleware get middleware =>
      (Handler inner) => (Request request) async {
        final Response response = await inner(request);
        if (!accepts(request) || !compressible(request, response)) return response;
        return response.change(
          body: response.read().transform(gzip.encoder),
          headers: <String, Object?>{
            HttpHeaders.contentEncodingHeader: _kGzip,
            // The compressed length isn't known until the stream ends.
            HttpHeaders.contentLengthHeader: null,
            HttpHeaders.varyHeader: _vary(response),
          },
        );
      };

  /// Whether the browser says it can read gzip.
  static bool accepts(Request request) =>
      (request.headers[HttpHeaders.acceptEncodingHeader] ?? '')
          .split(',')
          .map((String coding) => coding.split(';').first.trim().toLowerCase())
          .contains(_kGzip);

  /// Whether [response] is text with a body worth compressing, not compressed yet.
  static bool compressible(Request request, Response response) {
    if (request.method == 'HEAD') return false;
    if (_kBodilessStatuses.contains(response.statusCode)) return false;
    if (response.headers.containsKey(HttpHeaders.contentEncodingHeader)) return false;
    if (response.contentLength case final int length when length < _kMinBytes) {
      return false;
    }
    final String type = response.mimeType ?? '';
    return _kCompressibleTypes.any(type.startsWith);
  }

  // Caches must keep compressed and plain copies apart; keeps any Vary already set.
  static String _vary(Response response) =>
      switch (response.headers[HttpHeaders.varyHeader]) {
        final String vary => '$vary, ${HttpHeaders.acceptEncodingHeader}',
        null => HttpHeaders.acceptEncodingHeader,
      };
}

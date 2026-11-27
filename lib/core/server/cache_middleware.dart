import 'dart:io';

import 'package:jaspr/jaspr.dart';
import 'package:shelf/shelf.dart';

// Files whose names stay the same across releases (no hash in the name): the browser
// checks with the server before reusing them, and gets a short "not modified" if it can.
const List<String> _kRevalidatedFiles = <String>['.js', '.css', '.json', '.wasm'];
const String _kRevalidate = 'no-cache';

// Pictures and fonts rarely change: reused for a day without asking.
const List<String> _kLongLivedFiles = <String>[
  '.png',
  '.jpg',
  '.jpeg',
  '.webp',
  '.avif',
  '.svg',
  '.ico',
  '.woff2',
];
const String _kOneDay = 'public, max-age=86400';

/// Tells browsers how long they may reuse the site's static files.
///
/// Scripts and styles are revalidated on every use; pictures and fonts are kept for a
/// day, in release builds only, so `jaspr serve` always shows the latest files. Pages
/// and API answers are left alone, as is any response that already says.
abstract final class CacheMiddleware {
  static Middleware get middleware =>
      (Handler inner) => (Request request) async {
        final Response response = await inner(request);
        return switch (cacheControl(request, response, release: kReleaseMode)) {
          final String value => response.change(
            headers: <String, String>{HttpHeaders.cacheControlHeader: value},
          ),
          null => response,
        };
      };

  /// The `Cache-Control` value for [response], or null to leave it as it is.
  static String? cacheControl(
    Request request,
    Response response, {
    required bool release,
  }) {
    if (request.method != 'GET' || response.statusCode != HttpStatus.ok) return null;
    if (response.headers.containsKey(HttpHeaders.cacheControlHeader)) return null;
    final String path = request.url.path.toLowerCase();
    if (_kRevalidatedFiles.any(path.endsWith)) return _kRevalidate;
    if (release && _kLongLivedFiles.any(path.endsWith)) return _kOneDay;
    return null;
  }
}

import 'dart:io';

import 'package:presentation_site/core/server/cache_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

Request _get(String path, {String method = 'GET'}) =>
    Request(method, Uri.parse('http://localhost/$path'));

String? _control(String path, {bool release = true, Response? response}) =>
    CacheMiddleware.cacheControl(
      _get(path),
      response ?? Response.ok(''),
      release: release,
    );

void main() {
  group('cacheControl', () {
    test('revalidates scripts and styles', () {
      // Arrange
      const List<String> paths = <String>['main.client.dart.js', 'site.CSS'];

      // Act
      final Iterable<String?> values = paths.map(_control);

      // Assert
      expect(values, everyElement('no-cache'));
    });

    test('keeps pictures and fonts for a day in release builds', () {
      // Arrange
      const List<String> paths = <String>[
        'favicon.ico',
        'images/logo.svg',
        'inter.woff2',
      ];

      // Act
      final Iterable<String?> values = paths.map(_control);

      // Assert
      expect(values, everyElement('public, max-age=86400'));
    });

    test('leaves pictures alone while developing', () {
      // Arrange
      const String path = 'favicon.ico';

      // Act
      final String? value = _control(path, release: false);

      // Assert
      expect(value, isNull);
    });

    test('leaves pages, API answers and other methods alone', () {
      // Arrange
      final List<String?> values = <String?>[
        _control('work'),
        _control('api/contact'),
        CacheMiddleware.cacheControl(
          _get('main.client.dart.js', method: 'POST'),
          Response.ok(''),
          release: true,
        ),
      ];

      // Act
      final Iterable<String?> set = values.whereType<String>();

      // Assert
      expect(set, isEmpty);
    });

    test('leaves errors and responses that already say alone', () {
      // Arrange
      final List<String?> values = <String?>[
        _control('missing.js', response: Response.notFound('')),
        _control(
          'main.client.dart.js',
          response: Response.ok(
            '',
            headers: <String, String>{HttpHeaders.cacheControlHeader: 'no-store'},
          ),
        ),
      ];

      // Act
      final Iterable<String?> set = values.whereType<String>();

      // Assert
      expect(set, isEmpty);
    });
  });

  group('middleware', () {
    test('adds the header to a static file', () async {
      // Arrange
      final Handler handler = CacheMiddleware.middleware((Request _) => Response.ok(''));

      // Act
      final Response response = await handler(_get('main.client.dart.js'));

      // Assert
      expect(response.headers[HttpHeaders.cacheControlHeader], 'no-cache');
    });

    test('passes a page through unchanged', () async {
      // Arrange
      final Handler handler = CacheMiddleware.middleware((Request _) => Response.ok(''));

      // Act
      final Response response = await handler(_get('work'));

      // Assert
      expect(response.headers[HttpHeaders.cacheControlHeader], isNull);
    });
  });
}

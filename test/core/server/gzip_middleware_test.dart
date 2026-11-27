import 'dart:convert';
import 'dart:io';

import 'package:presentation_site/core/server/gzip_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

final Uri _kPage = Uri.parse('http://localhost/work');
final String _kLongText = 'a' * 4096;

Request _request({String? acceptEncoding, String method = 'GET'}) => Request(
  method,
  _kPage,
  headers: <String, String>{
    HttpHeaders.acceptEncodingHeader: ?acceptEncoding,
  },
);

Response _html(String body, {int status = HttpStatus.ok}) => Response(
  status,
  body: body,
  headers: <String, String>{HttpHeaders.contentTypeHeader: 'text/html'},
);

void main() {
  group('accepts', () {
    test('finds gzip among several codings', () {
      // Arrange
      final Request request = _request(acceptEncoding: 'br, GZIP;q=0.8, deflate');

      // Act
      final bool accepts = GzipMiddleware.accepts(request);

      // Assert
      expect(accepts, isTrue);
    });

    test('is false without the header', () {
      // Arrange
      final Request request = _request();

      // Act
      final bool accepts = GzipMiddleware.accepts(request);

      // Assert
      expect(accepts, isFalse);
    });

    test('is false for other codings only', () {
      // Arrange
      final Request request = _request(acceptEncoding: 'br, deflate');

      // Act
      final bool accepts = GzipMiddleware.accepts(request);

      // Assert
      expect(accepts, isFalse);
    });
  });

  group('compressible', () {
    test('is true for a long page', () {
      // Arrange
      final Response response = _html(_kLongText);

      // Act
      final bool compressible = GzipMiddleware.compressible(_request(), response);

      // Assert
      expect(compressible, isTrue);
    });

    test('is false for a short body', () {
      // Arrange
      final Response response = _html('short');

      // Act
      final bool compressible = GzipMiddleware.compressible(_request(), response);

      // Assert
      expect(compressible, isFalse);
    });

    test('is false for pictures', () {
      // Arrange
      final Response response = Response.ok(
        List<int>.filled(_kLongText.length, 0),
        headers: <String, String>{HttpHeaders.contentTypeHeader: 'image/png'},
      );

      // Act
      final bool compressible = GzipMiddleware.compressible(_request(), response);

      // Assert
      expect(compressible, isFalse);
    });

    test('is false for a body compressed already', () {
      // Arrange
      final Response response = _html(
        _kLongText,
      ).change(headers: <String, String>{HttpHeaders.contentEncodingHeader: 'br'});

      // Act
      final bool compressible = GzipMiddleware.compressible(_request(), response);

      // Assert
      expect(compressible, isFalse);
    });

    test('is false for HEAD requests and bodiless statuses', () {
      // Arrange
      final List<bool> results = <bool>[
        GzipMiddleware.compressible(_request(method: 'HEAD'), _html(_kLongText)),
        GzipMiddleware.compressible(
          _request(),
          Response.notModified(
            headers: <String, String>{HttpHeaders.contentTypeHeader: 'text/html'},
          ),
        ),
      ];

      // Act
      final bool any = results.any((bool result) => result);

      // Assert
      expect(any, isFalse);
    });
  });

  group('middleware', () {
    test('gzips a long page and says so', () async {
      // Arrange
      final Handler handler = GzipMiddleware.middleware((Request _) => _html(_kLongText));

      // Act
      final Response response = await handler(_request(acceptEncoding: 'gzip'));
      final List<int> bytes = await response
          .read()
          .expand((List<int> chunk) => chunk)
          .toList();

      // Assert
      expect(
        <Object?>[
          response.headers[HttpHeaders.contentEncodingHeader],
          response.headers[HttpHeaders.contentLengthHeader],
          response.headers[HttpHeaders.varyHeader],
          utf8.decode(gzip.decode(bytes)),
        ],
        <Object?>['gzip', null, HttpHeaders.acceptEncodingHeader, _kLongText],
      );
    });

    test('keeps a Vary header already set', () async {
      // Arrange
      final Handler handler = GzipMiddleware.middleware(
        (Request _) => _html(
          _kLongText,
        ).change(headers: <String, String>{HttpHeaders.varyHeader: 'Cookie'}),
      );

      // Act
      final Response response = await handler(_request(acceptEncoding: 'gzip'));

      // Assert
      expect(response.headers[HttpHeaders.varyHeader], 'Cookie, accept-encoding');
    });

    test('leaves the page as it is for a browser without gzip', () async {
      // Arrange
      final Handler handler = GzipMiddleware.middleware((Request _) => _html(_kLongText));

      // Act
      final Response response = await handler(_request());

      // Assert
      expect(
        <Object?>[
          response.headers[HttpHeaders.contentEncodingHeader],
          await response.readAsString(),
        ],
        <Object?>[null, _kLongText],
      );
    });
  });
}

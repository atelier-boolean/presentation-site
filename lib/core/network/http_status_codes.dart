/// The HTTP status codes the site sends and reads, by name.
///
/// `dart:io` has its own `HttpStatus`, but browser code can't import it.
abstract final class HttpStatusCodes {
  static const int ok = 200;
  static const int seeOther = 303;
  static const int badRequest = 400;
  static const int unsupportedMediaType = 415;

  /// Whether [code] means the request worked.
  static bool isSuccess(int code) => code >= ok && code < 300;
}

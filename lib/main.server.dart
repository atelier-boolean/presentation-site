library;

import 'dart:io';

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:presentation_site/core/server/api_handler.dart';
import 'package:presentation_site/main.server.options.dart';
import 'package:presentation_site/ui/app.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

const int _kPort = 8080;
const String _kSiteTitle = 'Portfolio';
// The language every page is written in.
const String _kLanguage = 'en';
// Inter, the site's typeface, from Google Fonts: regular, medium and semibold.
const String _kFontHost = 'https://fonts.googleapis.com';
const String _kFontFilesHost = 'https://fonts.gstatic.com';
const String _kInterStylesheet =
    '$_kFontHost/css2?family=Inter:wght@400;500;600&display=swap';

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  // main() runs again on every hot reload: only the latest run keeps its server.
  final Object reloadLock = activeReloadLock = Object();
  final HttpServer server = await shelf_io.serve(
    const Pipeline().addMiddleware(logRequests()).addHandler(_router.call),
    InternetAddress.anyIPv4,
    _kPort,
    shared: true,
  );
  if (reloadLock != activeReloadLock) {
    await server.close();
    return;
  }
  await activeServer?.close();
  activeServer = server;

  stdout.writeln('Serving at http://${server.address.host}:${server.port}');
}

Document get _document => const Document(
  lang: _kLanguage,
  title: _kSiteTitle,
  head: <Component>[
    link(rel: 'preconnect', href: _kFontHost),
    link(
      rel: 'preconnect',
      href: _kFontFilesHost,
      attributes: <String, String>{'crossorigin': ''},
    ),
    link(rel: 'stylesheet', href: _kInterStylesheet),
  ],
  body: App(),
);

Router get _router => Router()
  ..mount('/api', apiHandler)
  ..mount('/', serveApp((Request request, RenderFunction render) => render(_document)));

HttpServer? activeServer;
Object? activeReloadLock;

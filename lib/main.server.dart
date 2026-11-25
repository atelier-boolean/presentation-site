library;

import 'dart:io';

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'core/server/api_handler.dart';
import 'main.server.options.dart';
import 'ui/app.dart';

const int _kPort = 8080;
const String _kSiteTitle = 'Portfolio';

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  final router = Router()
    ..mount('/api', apiHandler)
    ..mount('/', serveApp((request, render) => render(_document)));

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  // main() runs again on every hot reload: only the latest run keeps its server.
  final reloadLock = activeReloadLock = Object();
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, _kPort, shared: true);
  if (reloadLock != activeReloadLock) {
    await server.close();
    return;
  }
  await activeServer?.close();
  activeServer = server;

  stdout.writeln('Serving at http://${server.address.host}:${server.port}');
}

Document get _document => Document(
  title: _kSiteTitle,
  head: [
    link(rel: 'manifest', href: 'manifest.json'),
    script(src: 'flutter_bootstrap.js', async: true),
  ],
  body: const App(),
);

HttpServer? activeServer;
Object? activeReloadLock;

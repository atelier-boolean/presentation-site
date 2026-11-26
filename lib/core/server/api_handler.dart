import 'package:presentation_site/core/server/contact_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

const String _kContactPath = '/contact';

/// API routes, mounted under /api. Unknown paths get the router's 404.
Handler get apiHandler => (Router()..post(_kContactPath, handleContact)).call;

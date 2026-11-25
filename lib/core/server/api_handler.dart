import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

// API routes, mounted under /api. Unknown paths get the router's 404.
Handler get apiHandler => Router().call;

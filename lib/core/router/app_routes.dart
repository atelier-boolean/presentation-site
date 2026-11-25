import 'package:jaspr_router/jaspr_router.dart';

import '../../ui/pages/home/home_page.dart';

abstract final class AppRoutes {
  static const String home = '/';

  static final List<RouteBase> all = [
    Route(path: home, title: 'Home', builder: (context, state) => const HomePage()),
  ];
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../core/router/app_routes.dart';
import '../core/theme/site_theme.dart';
import 'shared/site_header.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return DsTheme(
      data: siteTheme,
      child: Router(
        routes: [
          ShellRoute(
            builder: (context, state, child) => .fragment([
              const SiteHeader(),
              main_([child]),
            ]),
            routes: AppRoutes.all,
          ),
        ],
      ),
    );
  }
}

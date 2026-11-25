import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/core/theme/site_theme.dart';
import 'package:presentation_site/ui/shared/site_header.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return DsTheme(
      data: siteTheme,
      child: Router(
        routes: <RouteBase>[
          ShellRoute(
            builder: (BuildContext context, RouteState state, Component child) =>
                .fragment(<Component>[
                  const SiteHeader(),
                  main_(<Component>[child]),
                ]),
            routes: AppRoutes.all,
          ),
        ],
      ),
    );
  }
}

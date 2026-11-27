import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/site_content.dart';

/// The top bar on every page: the name, linking home, and the pages, marking the
/// current one.
class SiteHeader extends StatelessComponent {
  const SiteHeader({super.key});

  @override
  Component build(BuildContext context) {
    return DsTopBar(
      title: SiteContent.name,
      titleHref: AppRoutes.home,
      links: <DsNavLink>[
        for (final ({String label, String path}) page in AppRoutes.navigation)
          DsNavLink(
            label: page.label,
            href: page.path,
            isCurrent: context.url == page.path,
          ),
      ],
    );
  }
}

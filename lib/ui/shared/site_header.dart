import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/site_content.dart';

class SiteHeader extends StatelessComponent {
  static const List<({String label, String path})> _links =
      <({String label, String path})>[
        (label: 'Work', path: AppRoutes.work),
        (label: 'About', path: AppRoutes.about),
        (label: 'Contact', path: AppRoutes.contact),
      ];

  const SiteHeader({super.key});

  @override
  Component build(BuildContext context) {
    return DsTopBar(
      title: SiteContent.name,
      titleHref: AppRoutes.home,
      links: <DsNavLink>[
        for (final ({String label, String path}) link in _links)
          DsNavLink(
            label: link.label,
            href: link.path,
            isCurrent: context.url == link.path,
          ),
      ],
    );
  }
}

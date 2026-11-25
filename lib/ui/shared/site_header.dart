import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../core/router/app_routes.dart';
import '../../data/site_content.dart';

class SiteHeader extends StatelessComponent {
  static const List<({String label, String path})> _links = [
    (label: 'Work', path: AppRoutes.work),
    (label: 'About', path: AppRoutes.about),
    (label: 'Contact', path: AppRoutes.contact),
  ];

  const SiteHeader({super.key});

  @override
  Component build(BuildContext context) {
    final currentPath = context.url;
    return DsTopBar(
      title: SiteContent.name,
      titleHref: AppRoutes.home,
      links: [
        for (final link in _links) DsNavLink(label: link.label, href: link.path, isCurrent: currentPath == link.path),
      ],
    );
  }
}

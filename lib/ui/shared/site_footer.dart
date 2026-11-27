import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/site_content.dart';

/// The footer on every page: who the site is for, the pages, how to get in touch and
/// the copyright.
class SiteFooter extends StatelessComponent {
  const SiteFooter({super.key});

  @override
  Component build(BuildContext context) {
    return DsFooter(
      legal: const DsText.bodySmall(SiteContent.copyright, tone: .muted),
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x1,
          children: const <Component>[
            DsText.titleMedium(SiteContent.name, tag: .p),
            DsText.bodyMedium(SiteContent.role, tone: .muted),
          ],
        ),
        DsFooterLinks(
          title: SiteContent.pagesTitle,
          links: <DsFooterLink>[
            for (final ({String label, String path}) page in AppRoutes.navigation)
              DsFooterLink(label: page.label, href: page.path),
          ],
        ),
        const DsFooterLinks(
          title: SiteContent.contactTitle,
          links: <DsFooterLink>[
            DsFooterLink(label: SiteContent.email, href: SiteContent.emailHref),
          ],
        ),
      ],
    );
  }
}

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/site_content.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x6,
          style: const DsStyle(maxWidth: DsWidth.prose),
          children: const <Component>[
            DsText.titleMedium(SiteContent.role, tag: .p, tone: .primary),
            DsText.displayMedium(SiteContent.name),
            DsText.titleLarge(HomeContent.heroPitch, tag: .p, tone: .muted),
            DsRow(
              children: <Component>[
                DsLinkButton.primary(
                  label: HomeContent.seeWorkLabel,
                  href: AppRoutes.work,
                ),
                DsLinkButton.secondary(
                  label: HomeContent.contactLabel,
                  href: AppRoutes.contact,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

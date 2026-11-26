import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/home_content.dart';

class CallToActionSection extends StatelessComponent {
  const CallToActionSection({super.key});

  @override
  Component build(BuildContext context) {
    return const DsSection.tinted(
      children: <Component>[
        DsColumn.centered(
          children: <Component>[
            DsText.headlineMedium(HomeContent.ctaTitle),
            DsText.bodyLarge(HomeContent.ctaText, tone: .muted),
            DsLinkButton.primary(
              label: HomeContent.contactLabel,
              href: AppRoutes.contact,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../data/home_content.dart';
import '../../../../data/site_content.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return const DsSection.plain(
      children: [
        div(classes: 'hero', [
          p(classes: 'hero-role', [.text(SiteContent.role)]),
          h1([.text(SiteContent.name)]),
          p(classes: 'hero-pitch', [.text(HomeContent.heroPitch)]),
          div(classes: 'hero-actions', [
            DsLinkButton.primary(label: HomeContent.seeWorkLabel, href: AppRoutes.work),
            DsLinkButton.secondary(label: HomeContent.contactLabel, href: AppRoutes.contact),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero').styles(
      display: .flex,
      maxWidth: DsWidth.prose,
      flexDirection: .column,
      gap: const .all(DsSpacing.x6),
    ),
    css('.hero-role').styles(color: DsColors.primary, fontWeight: .w600),
    css('.hero-pitch').styles(color: DsColors.textMuted, fontSize: DsFontSize.xl),
    css('.hero-actions').styles(display: .flex, flexWrap: .wrap, gap: const .all(DsSpacing.x4)),
  ];
}

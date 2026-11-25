import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/site_content.dart';

const DsCssClass _kRoot = DsCssClass('hero');
final DsCssClass _kActions = _kRoot.part('actions');

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        div(classes: _kRoot.name, <Component>[
          const DsText.titleMedium(SiteContent.role, tag: .p, tone: .primary),
          const DsText.displayMedium(SiteContent.name),
          const DsText.titleLarge(HomeContent.heroPitch, tag: .p, tone: .muted),
          div(classes: _kActions.name, const <Component>[
            DsLinkButton.primary(label: HomeContent.seeWorkLabel, href: AppRoutes.work),
            DsLinkButton.secondary(
              label: HomeContent.contactLabel,
              href: AppRoutes.contact,
            ),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => <StyleRule>[
    css(_kRoot.selector).styles(
      display: .flex,
      maxWidth: DsWidth.prose,
      flexDirection: .column,
      gap: .all(DsSpacing.x6),
    ),
    css(
      _kActions.selector,
    ).styles(display: .flex, flexWrap: .wrap, gap: .all(DsSpacing.x4)),
  ];
}

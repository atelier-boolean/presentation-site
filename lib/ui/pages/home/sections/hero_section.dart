import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/site_content.dart';

const DsCssClass _kRoot = DsCssClass('hero');
final DsCssClass _kRole = _kRoot.part('role');
final DsCssClass _kPitch = _kRoot.part('pitch');
final DsCssClass _kActions = _kRoot.part('actions');

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        div(classes: _kRoot.name, <Component>[
          p(classes: _kRole.name, const <Component>[.text(SiteContent.role)]),
          const h1(<Component>[.text(SiteContent.name)]),
          p(classes: _kPitch.name, const <Component>[.text(HomeContent.heroPitch)]),
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
    css(_kRole.selector).styles(color: DsColors.primary, fontWeight: .w600),
    css(_kPitch.selector).styles(color: DsColors.textMuted, fontSize: DsFontSize.xl),
    css(
      _kActions.selector,
    ).styles(display: .flex, flexWrap: .wrap, gap: .all(DsSpacing.x4)),
  ];
}

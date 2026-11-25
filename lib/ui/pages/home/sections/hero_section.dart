import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../data/home_content.dart';
import '../../../../data/site_content.dart';

const DsCssClass _kRoot = DsCssClass('hero');
final DsCssClass _kRole = _kRoot.part('role');
final DsCssClass _kPitch = _kRoot.part('pitch');
final DsCssClass _kActions = _kRoot.part('actions');

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: [
        div(classes: _kRoot.name, [
          p(classes: _kRole.name, [const .text(SiteContent.role)]),
          const h1([.text(SiteContent.name)]),
          p(classes: _kPitch.name, [const .text(HomeContent.heroPitch)]),
          div(classes: _kActions.name, [
            const DsLinkButton.primary(label: HomeContent.seeWorkLabel, href: AppRoutes.work),
            const DsLinkButton.secondary(label: HomeContent.contactLabel, href: AppRoutes.contact),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css(_kRoot.selector).styles(
      display: .flex,
      maxWidth: DsWidth.prose,
      flexDirection: .column,
      gap: .all(DsSpacing.x6),
    ),
    css(_kRole.selector).styles(color: DsColors.primary, fontWeight: .w600),
    css(_kPitch.selector).styles(color: DsColors.textMuted, fontSize: DsFontSize.xl),
    css(_kActions.selector).styles(display: .flex, flexWrap: .wrap, gap: .all(DsSpacing.x4)),
  ];
}

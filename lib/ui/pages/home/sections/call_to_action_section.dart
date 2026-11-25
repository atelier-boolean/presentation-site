import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../data/home_content.dart';

const DsCssClass _kRoot = DsCssClass('call-to-action');

class CallToActionSection extends StatelessComponent {
  const CallToActionSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: [
        div(classes: _kRoot.name, [
          const h2([.text(HomeContent.ctaTitle)]),
          const p([.text(HomeContent.ctaText)]),
          const DsLinkButton.primary(label: HomeContent.contactLabel, href: AppRoutes.contact),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css(_kRoot.selector).styles(
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: .all(DsSpacing.x4),
      textAlign: .center,
    ),
    css('${_kRoot.selector} p').styles(color: DsColors.textMuted),
  ];
}

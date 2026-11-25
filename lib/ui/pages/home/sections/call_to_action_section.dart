import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../data/home_content.dart';

class CallToActionSection extends StatelessComponent {
  const CallToActionSection({super.key});

  @override
  Component build(BuildContext context) {
    return const DsSection.tinted(
      children: [
        div(classes: 'call-to-action', [
          h2([.text(HomeContent.ctaTitle)]),
          p([.text(HomeContent.ctaText)]),
          DsLinkButton.primary(label: HomeContent.contactLabel, href: AppRoutes.contact),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.call-to-action').styles(
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: const .all(DsSpacing.x4),
      textAlign: .center,
    ),
    css('.call-to-action p').styles(color: DsColors.textMuted),
  ];
}

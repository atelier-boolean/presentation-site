import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/core/router/app_routes.dart';
import 'package:presentation_site/data/home_content.dart';

const DsCssClass _kRoot = DsCssClass('call-to-action');

class CallToActionSection extends StatelessComponent {
  const CallToActionSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: <Component>[
        div(classes: _kRoot.name, const <Component>[
          DsText.headlineMedium(HomeContent.ctaTitle),
          DsText.bodyLarge(HomeContent.ctaText, tone: .muted),
          DsLinkButton.primary(label: HomeContent.contactLabel, href: AppRoutes.contact),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => <StyleRule>[
    css(_kRoot.selector).styles(
      display: .flex,
      flexDirection: .column,
      alignItems: .center,
      gap: .all(DsSpacing.x4),
      textAlign: .center,
    ),
  ];
}

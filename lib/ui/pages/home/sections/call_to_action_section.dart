import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../data/home_content.dart';
import '../../../shared/link_button.dart';
import '../../../shared/page_section.dart';

class CallToActionSection extends StatelessComponent {
  const CallToActionSection({super.key});

  @override
  Component build(BuildContext context) {
    return const PageSection.tinted(
      children: [
        div(classes: 'call-to-action', [
          h2([.text(HomeContent.ctaTitle)]),
          p([.text(HomeContent.ctaText)]),
          LinkButton.primary(label: HomeContent.contactLabel, to: AppRoutes.contact),
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
      gap: const .all(AppSizes.s400),
      textAlign: .center,
    ),
    css('.call-to-action p').styles(color: AppColors.textMuted),
  ];
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../data/home_content.dart';
import '../../../../data/site_content.dart';
import '../../../shared/link_button.dart';
import '../../../shared/page_section.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return const PageSection.plain(
      children: [
        div(classes: 'hero', [
          p(classes: 'hero-role', [.text(SiteContent.role)]),
          h1([.text(SiteContent.name)]),
          p(classes: 'hero-pitch', [.text(HomeContent.heroPitch)]),
          div(classes: 'hero-actions', [
            LinkButton.primary(label: HomeContent.seeWorkLabel, to: AppRoutes.work),
            LinkButton.secondary(label: HomeContent.contactLabel, to: AppRoutes.contact),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero').styles(
      display: .flex,
      maxWidth: AppSizes.textMaxWidth,
      flexDirection: .column,
      gap: const .all(AppSizes.s600),
    ),
    css('.hero-role').styles(color: AppColors.primary, fontWeight: .w600),
    css('.hero-pitch').styles(color: AppColors.textMuted, fontSize: AppSizes.fontTitle),
    css('.hero-actions').styles(display: .flex, flexWrap: .wrap, gap: const .all(AppSizes.s400)),
  ];
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import 'page_container.dart';

// A full-width band of a page, with its content centred at the site's width.
class PageSection extends StatelessComponent {
  const PageSection.plain({required this.children, super.key}) : _variant = 'page-section-plain';

  const PageSection.tinted({required this.children, super.key}) : _variant = 'page-section-tinted';

  final List<Component> children;
  final String _variant;

  @override
  Component build(BuildContext context) {
    return section(classes: 'page-section $_variant', [
      PageContainer(children: children),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page-section').styles(padding: const .symmetric(vertical: AppSizes.s2400)),
    css('.page-section-plain').styles(backgroundColor: AppColors.background),
    css('.page-section-tinted').styles(backgroundColor: AppColors.surface),
    css.media(const MediaQuery.screen(maxWidth: AppSizes.phoneMaxWidth), [
      css('.page-section').styles(padding: const .symmetric(vertical: AppSizes.s1600)),
    ]),
  ];
}

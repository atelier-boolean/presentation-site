import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_sizes.dart';

// Centres content at the site's maximum width, with side padding.
class PageContainer extends StatelessComponent {
  const PageContainer({required this.children, this.classes, super.key});

  final List<Component> children;
  final String? classes;

  @override
  Component build(BuildContext context) {
    return div(classes: ['page-container', ?classes].join(' '), children);
  }

  @css
  static List<StyleRule> get styles => [
    css('.page-container').styles(
      width: 100.percent,
      maxWidth: AppSizes.contentMaxWidth,
      padding: .symmetric(horizontal: AppSizes.s600),
      margin: .symmetric(horizontal: .auto),
    ),
  ];
}

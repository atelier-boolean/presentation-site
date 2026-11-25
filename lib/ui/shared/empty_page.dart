import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_sizes.dart';
import 'page_container.dart';

// A page with only its title, for pages not built yet.
class EmptyPage extends StatelessComponent {
  const EmptyPage({required this.title, super.key});

  final String title;

  @override
  Component build(BuildContext context) {
    return section(classes: 'empty-page', [
      PageContainer(
        children: [
          h1([.text(title)]),
        ],
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.empty-page').styles(padding: .symmetric(vertical: AppSizes.s2400)),
  ];
}

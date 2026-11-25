import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';

// A link that looks like a button: it navigates, so it stays an <a>.
class LinkButton extends StatelessComponent {
  const LinkButton.primary({required this.label, required this.to, super.key}) : _variant = 'link-button-primary';

  const LinkButton.secondary({required this.label, required this.to, super.key}) : _variant = 'link-button-secondary';

  final String label;
  final String to;
  final String _variant;

  @override
  Component build(BuildContext context) {
    return Link(to: to, classes: 'link-button $_variant', child: .text(label));
  }

  @css
  static List<StyleRule> get styles => [
    css('.link-button').styles(
      display: .inlineBlock,
      padding: const .symmetric(vertical: AppSizes.s300, horizontal: AppSizes.s600),
      border: const .all(style: .solid, color: AppColors.primary, width: AppSizes.borderThin),
      radius: const .all(.circular(AppSizes.radiusPill)),
      fontWeight: .w600,
      textDecoration: const TextDecoration(line: .none),
    ),
    css('.link-button-primary', [
      css('&').styles(color: AppColors.onPrimary, backgroundColor: AppColors.primary),
      css('&:hover').styles(backgroundColor: AppColors.primaryHover),
    ]),
    css('.link-button-secondary', [
      css('&').styles(color: AppColors.primary, backgroundColor: AppColors.background),
      css('&:hover').styles(backgroundColor: AppColors.surface),
    ]),
  ];
}

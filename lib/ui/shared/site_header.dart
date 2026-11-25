import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../data/site_content.dart';
import 'page_container.dart';

const int _kHeaderLayer = 10;

class SiteHeader extends StatelessComponent {
  const SiteHeader({super.key});

  static const List<({String label, String path})> _links = [
    (label: 'Work', path: AppRoutes.work),
    (label: 'About', path: AppRoutes.about),
    (label: 'Contact', path: AppRoutes.contact),
  ];

  @override
  Component build(BuildContext context) {
    final currentPath = context.url;
    return header(classes: 'site-header', [
      PageContainer(
        classes: 'site-header-row',
        children: [
          Link(to: AppRoutes.home, classes: 'site-header-name', child: const .text(SiteContent.name)),
          nav(classes: 'site-header-links', [
            for (final link in _links)
              _NavLink(label: link.label, path: link.path, isCurrent: currentPath == link.path),
          ]),
        ],
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.site-header').styles(
      position: const .sticky(top: Unit.zero),
      zIndex: const ZIndex(_kHeaderLayer),
      border: const .only(
        bottom: .solid(color: AppColors.border, width: AppSizes.borderThin),
      ),
      backgroundColor: AppColors.background,
    ),
    css('.site-header-row').styles(
      display: .flex,
      height: AppSizes.headerHeight,
      justifyContent: .spaceBetween,
      alignItems: .center,
      gap: const .all(AppSizes.s400),
    ),
    css('.site-header-name').styles(
      color: AppColors.text,
      fontWeight: .w700,
      textDecoration: const TextDecoration(line: .none),
      whiteSpace: .noWrap,
    ),
    css('.site-header-links').styles(display: .flex, gap: const .all(AppSizes.s600)),
    css('.nav-link', [
      css('&').styles(
        padding: const .symmetric(vertical: AppSizes.s100),
        border: const .only(
          bottom: .solid(color: AppColors.background, width: AppSizes.borderThin),
        ),
        color: AppColors.textMuted,
        textDecoration: const TextDecoration(line: .none),
      ),
      css('&:hover').styles(color: AppColors.text),
      css('&.nav-link-current').styles(
        border: const .only(
          bottom: .solid(color: AppColors.primary, width: AppSizes.borderThin),
        ),
        color: AppColors.text,
      ),
    ]),
    css.media(const MediaQuery.screen(maxWidth: AppSizes.phoneMaxWidth), [
      css('.site-header-links').styles(gap: const .all(AppSizes.s400), fontSize: AppSizes.fontSmall),
    ]),
  ];
}

class _NavLink extends StatelessComponent {
  const _NavLink({required this.label, required this.path, required this.isCurrent});

  final String label;
  final String path;
  final bool isCurrent;

  @override
  Component build(BuildContext context) {
    return Link(
      to: path,
      classes: isCurrent ? 'nav-link nav-link-current' : 'nav-link',
      attributes: isCurrent ? const {'aria-current': 'page'} : null,
      child: .text(label),
    );
  }
}

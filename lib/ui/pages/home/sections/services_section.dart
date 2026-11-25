import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../data/home_content.dart';
import '../../../../data/models/design_service.dart';
import '../../../shared/card_grid.dart';
import '../../../shared/page_section.dart';

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return PageSection.plain(
      children: [
        const h2(classes: 'services-title', [.text(HomeContent.servicesTitle)]),
        CardGrid(
          children: [
            for (final service in HomeContent.services) _ServiceItem(service: service),
          ],
        ),
      ],
    );
  }

  // Also styles _ServiceItem: Jaspr only collects @css from public classes.
  @css
  static List<StyleRule> get styles => [
    css('.services-title').styles(margin: const .only(bottom: AppSizes.s800)),
    css('.service-item').styles(display: .flex, flexDirection: .column, gap: const .all(AppSizes.s200)),
    css('.service-item p').styles(color: AppColors.textMuted),
  ];
}

class _ServiceItem extends StatelessComponent {
  const _ServiceItem({required this.service});

  final DesignService service;

  @override
  Component build(BuildContext context) {
    return div(classes: 'service-item', [
      h3([.text(service.title)]),
      p([.text(service.description)]),
    ]);
  }
}

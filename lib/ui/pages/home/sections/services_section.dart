import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../data/home_content.dart';
import '../../../../data/models/design_service.dart';

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: [
        const h2(classes: 'services-title', [.text(HomeContent.servicesTitle)]),
        DsGrid(
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
    css('.services-title').styles(margin: const .only(bottom: DsSpacing.x8)),
    css('.service-item').styles(display: .flex, flexDirection: .column, gap: const .all(DsSpacing.x2)),
    css('.service-item p').styles(color: DsColors.textMuted),
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

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/models/design_service.dart';

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x8,
          children: <Component>[
            const DsText.headlineMedium(HomeContent.servicesTitle),
            DsGrid(
              children: <Component>[
                for (final DesignService service in HomeContent.services)
                  _ServiceItem(service: service),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceItem extends StatelessComponent {
  final DesignService service;

  const _ServiceItem({required this.service});

  @override
  Component build(BuildContext context) {
    return DsColumn.start(
      spacing: DsSpacing.x2,
      children: <Component>[
        DsText.titleLarge(service.title),
        DsText.bodyLarge(service.description, tone: .muted),
      ],
    );
  }
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/models/design_service.dart';

const DsCssClass _kRoot = DsCssClass('services');
const DsCssClass _kItem = DsCssClass('service-item');

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        div(classes: _kRoot.name, <Component>[
          const DsText.headlineMedium(HomeContent.servicesTitle),
          DsGrid(
            children: <Component>[
              for (final DesignService service in HomeContent.services)
                _ServiceItem(service: service),
            ],
          ),
        ]),
      ],
    );
  }

  // Also styles _ServiceItem: Jaspr only collects @css from public classes.
  @css
  static List<StyleRule> get styles => <StyleRule>[
    css(
      _kRoot.selector,
    ).styles(display: .flex, flexDirection: .column, gap: .all(DsSpacing.x8)),
    css(
      _kItem.selector,
    ).styles(display: .flex, flexDirection: .column, gap: .all(DsSpacing.x2)),
  ];
}

class _ServiceItem extends StatelessComponent {
  final DesignService service;

  const _ServiceItem({required this.service});

  @override
  Component build(BuildContext context) {
    return div(classes: _kItem.name, <Component>[
      DsText.titleLarge(service.title),
      DsText.bodyLarge(service.description, tone: .muted),
    ]);
  }
}

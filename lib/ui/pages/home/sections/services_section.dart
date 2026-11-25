import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/models/design_service.dart';

const DsCssClass _kTitle = DsCssClass('services-title');
const DsCssClass _kItem = DsCssClass('service-item');

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        h2(classes: _kTitle.name, const <Component>[.text(HomeContent.servicesTitle)]),
        DsGrid(
          children: <Component>[
            for (final DesignService service in HomeContent.services)
              _ServiceItem(service: service),
          ],
        ),
      ],
    );
  }

  // Also styles _ServiceItem: Jaspr only collects @css from public classes.
  @css
  static List<StyleRule> get styles => <StyleRule>[
    css(_kTitle.selector).styles(margin: .only(bottom: DsSpacing.x8)),
    css(
      _kItem.selector,
    ).styles(display: .flex, flexDirection: .column, gap: .all(DsSpacing.x2)),
    css('${_kItem.selector} p').styles(color: DsColors.textMuted),
  ];
}

class _ServiceItem extends StatelessComponent {
  final DesignService service;

  const _ServiceItem({required this.service});

  @override
  Component build(BuildContext context) {
    return div(classes: _kItem.name, <Component>[
      h3(<Component>[.text(service.title)]),
      p(<Component>[.text(service.description)]),
    ]);
  }
}

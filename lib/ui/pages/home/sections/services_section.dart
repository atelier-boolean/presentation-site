import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../data/home_content.dart';
import '../../../../data/models/design_service.dart';

const DsCssClass _kTitle = DsCssClass('services-title');
const DsCssClass _kItem = DsCssClass('service-item');

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: [
        h2(classes: _kTitle.name, [const .text(HomeContent.servicesTitle)]),
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
    css(_kTitle.selector).styles(margin: .only(bottom: DsSpacing.x8)),
    css(_kItem.selector).styles(display: .flex, flexDirection: .column, gap: .all(DsSpacing.x2)),
    css('${_kItem.selector} p').styles(color: DsColors.textMuted),
  ];
}

class _ServiceItem extends StatelessComponent {
  final DesignService service;

  const _ServiceItem({required this.service});

  @override
  Component build(BuildContext context) {
    return div(classes: _kItem.name, [
      h3([.text(service.title)]),
      p([.text(service.description)]),
    ]);
  }
}

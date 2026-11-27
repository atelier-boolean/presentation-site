import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/work_content.dart';
import 'package:presentation_site/ui/pages/work/work_browser.dart';

/// The Work page: a short intro, then every case study, searchable and filtered by type.
class WorkPage extends StatelessComponent {
  const WorkPage({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x8,
          children: const <Component>[
            DsColumn.start(
              children: <Component>[
                DsText.displaySmall(WorkContent.title),
                DsText.bodyLarge(WorkContent.intro, tone: .muted),
              ],
            ),
            WorkBrowser(),
          ],
        ),
      ],
    );
  }
}

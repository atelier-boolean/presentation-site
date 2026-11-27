import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/data/models/case_study_type.dart';
import 'package:presentation_site/data/work_content.dart';
import 'package:presentation_site/ui/pages/work/work_state.dart';
import 'package:presentation_site/ui/pages/work/work_view_model.dart';
import 'package:presentation_site/ui/shared/case_study_card.dart';

/// The Work page's search, type chips and case studies, run in the browser.
///
/// Before its code runs, the page shows every case study.
@client
class WorkBrowser extends StatefulComponent {
  const WorkBrowser({super.key});

  @override
  State<WorkBrowser> createState() => _WorkBrowserState();
}

/// Owns the view model and closes it.
class _WorkBrowserState extends State<WorkBrowser> {
  final WorkViewModel _viewModel = WorkViewModel(caseStudies: WorkContent.caseStudies);

  @override
  void dispose() {
    unawaited(_viewModel.close());
    super.dispose();
  }

  @override
  Component build(BuildContext context) => VmBuilder<WorkState>(
    viewModel: _viewModel,
    builder: (BuildContext context, WorkState state) => DsColumn.start(
      spacing: DsSpacing.x6,
      children: <Component>[
        DsFormField.search(
          labelText: WorkContent.searchLabel,
          name: WorkContent.searchName,
          placeholder: WorkContent.searchPlaceholder,
          value: state.query,
          onChanged: _viewModel.search,
        ),
        DsChipGroup<CaseStudyType>.single(
          label: WorkContent.typesLabel,
          options: CaseStudyType.values,
          labelOf: (CaseStudyType type) => type.label,
          selected: state.type,
          onChanged: _viewModel.selectType,
        ),
        switch (state) {
          WorkShowing(:final List<CaseStudyPreview> caseStudies) => DsGrid(
            children: <Component>[
              for (final CaseStudyPreview caseStudy in caseStudies)
                CaseStudyCard(caseStudy: caseStudy),
            ],
          ),
          WorkNoMatch() => _NoMatch(onShowAll: _viewModel.showAll),
        },
      ],
    ),
  );
}

/// Says nothing matches, with a button that clears the search and type.
class _NoMatch extends StatelessComponent {
  final VoidCallback onShowAll;

  const _NoMatch({required this.onShowAll});

  @override
  Component build(BuildContext context) => DsEmptyState.card(
    icon: DsIcon(DsIcons.search, size: DsFontSize.x3l),
    title: WorkContent.noMatchTitle,
    text: WorkContent.noMatchText,
    action: DsButton.secondary(label: WorkContent.showAll, onTap: onShowAll),
  );
}

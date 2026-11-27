import 'dart:async';

import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/data/models/case_study_type.dart';
import 'package:presentation_site/ui/pages/work/work_state.dart';

/// Filters the Work page's case studies by search text and type.
///
/// The search text shows at once; the list follows once typing pauses for
/// [searchDelay], so it doesn't jump on every key.
final class WorkViewModel extends RxViewModel<WorkState> {
  /// How long typing pauses before the list follows the search.
  static const Duration searchDelay = Duration(milliseconds: 300);

  final List<CaseStudyPreview> _caseStudies;
  final Duration _delay;
  Timer? _searchTimer;

  /// [delay] is [searchDelay] unless a test shortens it.
  WorkViewModel({
    required List<CaseStudyPreview> caseStudies,
    Duration delay = searchDelay,
  }) : _caseStudies = caseStudies,
       _delay = delay,
       super(WorkShowing(query: '', type: null, caseStudies: caseStudies));

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }

  /// Shows [query] in the field now, and filters by it once typing pauses.
  void search(String query) {
    emit(switch (state) {
      WorkShowing(
        :final CaseStudyType? type,
        :final List<CaseStudyPreview> caseStudies,
      ) =>
        WorkShowing(query: query, type: type, caseStudies: caseStudies),
      WorkNoMatch(:final CaseStudyType? type) => WorkNoMatch(query: query, type: type),
    });
    _searchTimer?.cancel();
    _searchTimer = Timer(_delay, () => _filter(query: query, type: state.type));
  }

  /// Filters by [type] at once; null shows every type.
  void selectType(CaseStudyType? type) => _filter(query: state.query, type: type);

  /// Clears the search and the type.
  void showAll() => _filter(query: '', type: null);

  void _filter({required String query, required CaseStudyType? type}) {
    _searchTimer?.cancel();
    final List<CaseStudyPreview> matches = _caseStudies
        .where(
          (CaseStudyPreview caseStudy) =>
              (type == null || caseStudy.type == type) && caseStudy.matches(query),
        )
        .toList();
    emit(
      matches.isEmpty
          ? WorkNoMatch(query: query, type: type)
          : WorkShowing(query: query, type: type, caseStudies: matches),
    );
  }
}

import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/data/models/case_study_type.dart';

/// What the Work page shows: the search text, the chosen type and what matches them.
/// Equal states are equal values, so the view model skips repeats.
sealed class WorkState {
  /// The search text as typed.
  final String query;

  /// The chosen type of project; null for every type.
  final CaseStudyType? type;

  const WorkState({required this.query, required this.type});
}

/// Some case studies match.
final class WorkShowing extends WorkState {
  final List<CaseStudyPreview> caseStudies;

  const WorkShowing({
    required super.query,
    required super.type,
    required this.caseStudies,
  });

  @override
  bool operator ==(Object other) =>
      other is WorkShowing &&
      other.query == query &&
      other.type == type &&
      other.caseStudies.length == caseStudies.length &&
      Iterable<int>.generate(
        caseStudies.length,
      ).every((int index) => other.caseStudies[index] == caseStudies[index]);

  @override
  int get hashCode => Object.hash(query, type, Object.hashAll(caseStudies));
}

/// Nothing matches the search and type.
final class WorkNoMatch extends WorkState {
  const WorkNoMatch({required super.query, required super.type});

  @override
  bool operator ==(Object other) =>
      other is WorkNoMatch && other.query == query && other.type == type;

  @override
  int get hashCode => Object.hash(query, type);
}

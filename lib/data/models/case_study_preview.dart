import 'package:presentation_site/data/models/case_study_type.dart';

/// A case study as shown on a card: enough to tease it, not the full story.
class CaseStudyPreview {
  final String title;
  final CaseStudyType type;
  final String summary;

  const CaseStudyPreview({
    required this.title,
    required this.type,
    required this.summary,
  });

  /// Whether [query] appears in the title, type or summary, ignoring case and the spaces
  /// around it. An empty query matches every case study.
  bool matches(String query) {
    final String needle = query.trim().toLowerCase();
    return <String>[
      title,
      type.label,
      summary,
    ].any((String text) => text.toLowerCase().contains(needle));
  }
}

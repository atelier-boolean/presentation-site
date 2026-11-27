import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:test/test.dart';

const CaseStudyPreview _kCaseStudy = CaseStudyPreview(
  title: 'Clinic booking site',
  type: .website,
  summary: 'Fewer steps to book.',
);

void main() {
  group('matches', () {
    test('finds a word in the title, ignoring case', () {
      // Arrange
      const String query = 'BOOKING';

      // Act
      final bool matches = _kCaseStudy.matches(query);

      // Assert
      expect(matches, isTrue);
    });

    test('finds the type label and the summary', () {
      // Arrange
      const List<String> queries = <String>['website', 'fewer steps'];

      // Act
      final Iterable<bool> matches = queries.map(_kCaseStudy.matches);

      // Assert
      expect(matches, everyElement(isTrue));
    });

    test('rejects a word that appears nowhere', () {
      // Arrange
      const String query = 'coffee';

      // Act
      final bool matches = _kCaseStudy.matches(query);

      // Assert
      expect(matches, isFalse);
    });

    test('matches everything for an empty or blank query', () {
      // Arrange
      const List<String> queries = <String>['', '   '];

      // Act
      final Iterable<bool> matches = queries.map(_kCaseStudy.matches);

      // Assert
      expect(matches, everyElement(isTrue));
    });

    test('ignores spaces around the query', () {
      // Arrange
      const String query = '  clinic  ';

      // Act
      final bool matches = _kCaseStudy.matches(query);

      // Assert
      expect(matches, isTrue);
    });
  });
}

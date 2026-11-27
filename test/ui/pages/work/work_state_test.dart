import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/ui/pages/work/work_state.dart';
import 'package:test/test.dart';

const CaseStudyPreview _kFirst = CaseStudyPreview(
  title: 'First',
  type: .app,
  summary: 'One.',
);
const CaseStudyPreview _kSecond = CaseStudyPreview(
  title: 'Second',
  type: .branding,
  summary: 'Two.',
);

void main() {
  group('WorkShowing', () {
    test('equals another with the same query, type and case studies', () {
      // Arrange
      final WorkShowing first = WorkShowing(
        query: 'a',
        type: .app,
        caseStudies: List<CaseStudyPreview>.of(<CaseStudyPreview>[_kFirst]),
      );
      final WorkShowing second = WorkShowing(
        query: 'a',
        type: .app,
        caseStudies: List<CaseStudyPreview>.of(<CaseStudyPreview>[_kFirst]),
      );

      // Act
      final bool equal = first == second && first.hashCode == second.hashCode;

      // Assert
      expect(equal, isTrue);
    });

    test('differs when the case studies are in another order', () {
      // Arrange
      const WorkShowing first = WorkShowing(
        query: '',
        type: null,
        caseStudies: <CaseStudyPreview>[_kFirst, _kSecond],
      );
      const WorkShowing second = WorkShowing(
        query: '',
        type: null,
        caseStudies: <CaseStudyPreview>[_kSecond, _kFirst],
      );

      // Act
      final bool equal = first == second;

      // Assert
      expect(equal, isFalse);
    });

    test('differs when the query differs', () {
      // Arrange
      const WorkShowing first = WorkShowing(
        query: 'a',
        type: null,
        caseStudies: <CaseStudyPreview>[],
      );
      const WorkShowing second = WorkShowing(
        query: 'b',
        type: null,
        caseStudies: <CaseStudyPreview>[],
      );

      // Act
      final bool equal = first == second;

      // Assert
      expect(equal, isFalse);
    });
  });

  group('WorkNoMatch', () {
    test('equals another with the same query and type', () {
      // Arrange
      const WorkNoMatch first = WorkNoMatch(query: 'x', type: .website);
      const WorkNoMatch second = WorkNoMatch(query: 'x', type: .website);

      // Act
      final bool equal = first == second && first.hashCode == second.hashCode;

      // Assert
      expect(equal, isTrue);
    });

    test('differs when the type differs', () {
      // Arrange
      const WorkNoMatch first = WorkNoMatch(query: 'x', type: .website);
      const WorkNoMatch second = WorkNoMatch(query: 'x', type: null);

      // Act
      final bool equal = first == second;

      // Assert
      expect(equal, isFalse);
    });
  });
}

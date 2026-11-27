import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/ui/pages/work/work_state.dart';
import 'package:presentation_site/ui/pages/work/work_view_model.dart';
import 'package:test/test.dart';

const CaseStudyPreview _kApp = CaseStudyPreview(
  title: 'Banking app',
  type: .app,
  summary: 'Spending.',
);
const CaseStudyPreview _kSite = CaseStudyPreview(
  title: 'Clinic site',
  type: .website,
  summary: 'Booking.',
);
const List<CaseStudyPreview> _kAll = <CaseStudyPreview>[_kApp, _kSite];

/// A view model whose search applies on the next turn of the event loop.
WorkViewModel _viewModel() => WorkViewModel(caseStudies: _kAll, delay: Duration.zero);

/// Lets a pending search timer fire.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  group('WorkViewModel', () {
    test('starts with every case study', () {
      // Arrange
      final WorkViewModel viewModel = _viewModel();

      // Act
      final WorkState state = viewModel.state;

      // Assert
      expect(
        state,
        const WorkShowing(query: '', type: null, caseStudies: _kAll),
      );
    });
  });

  group('search', () {
    test('shows the text at once and filters once typing pauses', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();
      final List<WorkState> states = <WorkState>[];
      viewModel.stream.listen(states.add);

      // Act
      viewModel.search('clinic');
      await _settle();
      await viewModel.close();

      // Assert
      expect(states, const <WorkState>[
        WorkShowing(query: '', type: null, caseStudies: _kAll),
        WorkShowing(query: 'clinic', type: null, caseStudies: _kAll),
        WorkShowing(
          query: 'clinic',
          type: null,
          caseStudies: <CaseStudyPreview>[_kSite],
        ),
      ]);
    });

    test('filters only by the last text typed', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();

      // Act
      viewModel
        ..search('clin')
        ..search('bank');
      await _settle();

      // Assert
      expect(
        viewModel.state,
        const WorkShowing(
          query: 'bank',
          type: null,
          caseStudies: <CaseStudyPreview>[_kApp],
        ),
      );
    });

    test('ends with no match when nothing fits', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();

      // Act
      viewModel.search('coffee');
      await _settle();

      // Assert
      expect(viewModel.state, const WorkNoMatch(query: 'coffee', type: null));
    });

    test('keeps no match while typing after one', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();
      viewModel.search('coffee');
      await _settle();

      // Act
      viewModel.search('coffe');

      // Assert
      expect(viewModel.state, const WorkNoMatch(query: 'coffe', type: null));
    });

    test('never filters after the view model is closed', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();
      viewModel.search('clinic');

      // Act
      await viewModel.close();
      await _settle();

      // Assert
      expect(
        viewModel.state,
        const WorkShowing(query: 'clinic', type: null, caseStudies: _kAll),
      );
    });
  });

  group('selectType', () {
    test('filters by type at once, keeping the search', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel();
      viewModel.search('a');
      await _settle();

      // Act
      viewModel.selectType(.app);

      // Assert
      expect(
        viewModel.state,
        const WorkShowing(
          query: 'a',
          type: .app,
          caseStudies: <CaseStudyPreview>[_kApp],
        ),
      );
    });

    test('shows every type again when cleared', () {
      // Arrange
      final WorkViewModel viewModel = _viewModel()..selectType(.website);

      // Act
      viewModel.selectType(null);

      // Assert
      expect(
        viewModel.state,
        const WorkShowing(query: '', type: null, caseStudies: _kAll),
      );
    });

    test('ends with no match for a type with no case studies', () {
      // Arrange
      final WorkViewModel viewModel = _viewModel();

      // Act
      viewModel.selectType(.branding);

      // Assert
      expect(viewModel.state, const WorkNoMatch(query: '', type: .branding));
    });
  });

  group('showAll', () {
    test('clears the search and the type', () async {
      // Arrange
      final WorkViewModel viewModel = _viewModel()..selectType(.branding);
      viewModel.search('coffee');

      // Act
      viewModel.showAll();
      await _settle();

      // Assert
      expect(
        viewModel.state,
        const WorkShowing(query: '', type: null, caseStudies: _kAll),
      );
    });
  });
}

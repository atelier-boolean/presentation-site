import 'package:presentation_site/data/models/case_study_preview.dart';

/// The Work page's texts and every case study, newest first.
abstract final class WorkContent {
  static const String title = 'Work';
  static const String intro =
      'Apps, websites and brands I designed, with the problems they solved.';
  static const String searchLabel = 'Search projects';
  static const String searchName = 'query';
  static const String searchPlaceholder = 'A word, such as booking';
  static const String typesLabel = 'Type of project';
  static const String noMatchTitle = 'No projects match';
  static const String noMatchText = 'Try another word or type, or show every project.';
  static const String showAll = 'Show all';

  static const List<CaseStudyPreview> caseStudies = <CaseStudyPreview>[
    CaseStudyPreview(
      title: 'Banking app redesign',
      type: .app,
      summary: 'A simpler way to track spending, tested with 40 people.',
    ),
    CaseStudyPreview(
      title: 'Clinic booking site',
      type: .website,
      summary: 'Booking an appointment went from 7 steps to 3.',
    ),
    CaseStudyPreview(
      title: 'Coffee brand identity',
      type: .branding,
      summary: 'A new logo, colours and packaging for a local roaster.',
    ),
    CaseStudyPreview(
      title: 'Running club app',
      type: .app,
      summary: 'Weekly runs, routes and results in one place for 300 members.',
    ),
    CaseStudyPreview(
      title: 'Bookshop website',
      type: .website,
      summary: 'Online orders for a small shop, with pickup booked in two taps.',
    ),
    CaseStudyPreview(
      title: 'Bakery rebrand',
      type: .branding,
      summary: 'A warmer look for a family bakery, from signs to bread bags.',
    ),
  ];
}

import 'models/case_study_preview.dart';
import 'models/design_service.dart';

abstract final class HomeContent {
  static const String heroPitch =
      'I design calm, clear apps and websites that people enjoy using, from the first sketch to the last pixel.';
  static const String seeWorkLabel = 'See my work';
  static const String contactLabel = 'Get in touch';

  static const String featuredTitle = 'Selected work';
  static const List<CaseStudyPreview> featuredWork = [
    CaseStudyPreview(
      title: 'Banking app redesign',
      type: 'Mobile app',
      summary: 'A simpler way to track spending, tested with 40 people.',
    ),
    CaseStudyPreview(
      title: 'Clinic booking site',
      type: 'Website',
      summary: 'Booking an appointment went from 7 steps to 3.',
    ),
    CaseStudyPreview(
      title: 'Coffee brand identity',
      type: 'Branding',
      summary: 'A new logo, colours and packaging for a local roaster.',
    ),
  ];

  static const String servicesTitle = 'What I do';
  static const List<DesignService> services = [
    DesignService(
      title: 'UX research',
      description: 'Interviews and tests that show what people really need.',
    ),
    DesignService(
      title: 'UI design',
      description: 'Interfaces that look good and stay easy to use.',
    ),
    DesignService(
      title: 'Prototyping',
      description: 'Clickable prototypes to try ideas before they are built.',
    ),
  ];

  static const String ctaTitle = 'Have a project in mind?';
  static const String ctaText = 'Tell me about it. I usually reply within two days.';
}

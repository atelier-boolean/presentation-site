import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/data/models/design_service.dart';
import 'package:presentation_site/data/work_content.dart';

// How many case studies Home shows.
const int _kFeaturedCount = 3;

/// The Home page's texts.
abstract final class HomeContent {
  static const String heroPitch =
      'I design calm, clear apps and websites that people enjoy using, '
      'from the first sketch to the last pixel.';
  static const String seeWorkLabel = 'See my work';
  static const String contactLabel = 'Get in touch';

  static const String featuredTitle = 'Selected work';

  /// The newest case studies, shown on Home.
  static final List<CaseStudyPreview> featuredWork = WorkContent.caseStudies
      .take(_kFeaturedCount)
      .toList();

  static const String servicesTitle = 'What I do';
  static const List<DesignService> services = <DesignService>[
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

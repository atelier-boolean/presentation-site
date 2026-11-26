import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/ui/shared/case_study_card.dart';

class FeaturedWorkSection extends StatelessComponent {
  const FeaturedWorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x8,
          children: <Component>[
            const DsText.headlineMedium(HomeContent.featuredTitle),
            DsGrid(
              children: <Component>[
                for (final CaseStudyPreview caseStudy in HomeContent.featuredWork)
                  CaseStudyCard(caseStudy: caseStudy),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

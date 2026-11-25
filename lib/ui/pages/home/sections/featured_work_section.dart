import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../data/home_content.dart';
import '../../../shared/case_study_card.dart';

class FeaturedWorkSection extends StatelessComponent {
  const FeaturedWorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: [
        const h2(classes: 'featured-work-title', [.text(HomeContent.featuredTitle)]),
        DsGrid(
          children: [
            for (final caseStudy in HomeContent.featuredWork) CaseStudyCard(caseStudy: caseStudy),
          ],
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.featured-work-title').styles(margin: const .only(bottom: DsSpacing.x8)),
  ];
}

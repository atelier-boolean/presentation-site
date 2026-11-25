import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../data/home_content.dart';
import '../../../shared/card_grid.dart';
import '../../../shared/case_study_card.dart';
import '../../../shared/page_section.dart';

class FeaturedWorkSection extends StatelessComponent {
  const FeaturedWorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return PageSection.tinted(
      children: [
        const h2(classes: 'featured-work-title', [.text(HomeContent.featuredTitle)]),
        CardGrid(
          children: [
            for (final caseStudy in HomeContent.featuredWork) CaseStudyCard(caseStudy: caseStudy),
          ],
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.featured-work-title').styles(margin: const .only(bottom: AppSizes.s800)),
  ];
}

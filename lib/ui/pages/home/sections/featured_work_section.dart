import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../../../data/home_content.dart';
import '../../../shared/case_study_card.dart';

const DsCssClass _kTitle = DsCssClass('featured-work-title');

class FeaturedWorkSection extends StatelessComponent {
  const FeaturedWorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: [
        h2(classes: _kTitle.name, [const .text(HomeContent.featuredTitle)]),
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
    css(_kTitle.selector).styles(margin: .only(bottom: DsSpacing.x8)),
  ];
}

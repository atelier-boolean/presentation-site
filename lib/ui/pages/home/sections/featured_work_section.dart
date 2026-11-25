import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:presentation_site/data/home_content.dart';
import 'package:presentation_site/data/models/case_study_preview.dart';
import 'package:presentation_site/ui/shared/case_study_card.dart';

const DsCssClass _kRoot = DsCssClass('featured-work');

class FeaturedWorkSection extends StatelessComponent {
  const FeaturedWorkSection({super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.tinted(
      children: <Component>[
        div(classes: _kRoot.name, <Component>[
          const DsText.headlineMedium(HomeContent.featuredTitle),
          DsGrid(
            children: <Component>[
              for (final CaseStudyPreview caseStudy in HomeContent.featuredWork)
                CaseStudyCard(caseStudy: caseStudy),
            ],
          ),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => <StyleRule>[
    css(
      _kRoot.selector,
    ).styles(display: .flex, flexDirection: .column, gap: .all(DsSpacing.x8)),
  ];
}

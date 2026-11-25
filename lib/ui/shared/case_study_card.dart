import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../data/models/case_study_preview.dart';

const double _kImageAspectRatio = 4 / 3;

class CaseStudyCard extends StatelessComponent {
  const CaseStudyCard({required this.caseStudy, super.key});

  final CaseStudyPreview caseStudy;

  @override
  Component build(BuildContext context) {
    return article(classes: 'case-study-card', [
      // Stand-in for the cover image, hidden from screen readers.
      div(classes: 'case-study-card-image', attributes: const {'aria-hidden': 'true'}, []),
      div(classes: 'case-study-card-body', [
        span(classes: 'case-study-card-type', [.text(caseStudy.type)]),
        h3([.text(caseStudy.title)]),
        p([.text(caseStudy.summary)]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.case-study-card').styles(
      border: const .all(style: .solid, color: AppColors.border, width: AppSizes.borderThin),
      radius: const .all(.circular(AppSizes.radiusLarge)),
      overflow: .hidden,
      backgroundColor: AppColors.background,
    ),
    css('.case-study-card-image').styles(
      width: 100.percent,
      backgroundColor: AppColors.placeholder,
      raw: {'aspect-ratio': '$_kImageAspectRatio'},
    ),
    css('.case-study-card-body').styles(
      display: .flex,
      padding: const .all(AppSizes.s600),
      flexDirection: .column,
      gap: const .all(AppSizes.s200),
    ),
    css('.case-study-card-type').styles(
      color: AppColors.primary,
      fontSize: AppSizes.fontSmall,
      fontWeight: .w600,
    ),
    css('.case-study-card-body p').styles(color: AppColors.textMuted),
  ];
}

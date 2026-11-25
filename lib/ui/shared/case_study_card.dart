import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

import '../../data/models/case_study_preview.dart';

class CaseStudyCard extends StatelessComponent {
  const CaseStudyCard({required this.caseStudy, super.key});

  final CaseStudyPreview caseStudy;

  @override
  Component build(BuildContext context) {
    return DsCard(
      media: const DsMediaPlaceholder.landscape(),
      label: caseStudy.type,
      title: caseStudy.title,
      text: caseStudy.summary,
    );
  }
}

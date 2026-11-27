/// The kind of project a case study is about, used to filter the Work page.
enum CaseStudyType {
  app('Mobile app'),
  website('Website'),
  branding('Branding');

  /// How the type reads on cards and filter chips.
  final String label;

  const CaseStudyType(this.label);
}

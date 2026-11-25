import 'package:jaspr/jaspr.dart';

import 'sections/call_to_action_section.dart';
import 'sections/featured_work_section.dart';
import 'sections/hero_section.dart';
import 'sections/services_section.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return const .fragment([
      HeroSection(),
      FeaturedWorkSection(),
      ServicesSection(),
      CallToActionSection(),
    ]);
  }
}

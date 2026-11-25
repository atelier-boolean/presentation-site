import 'package:jaspr/jaspr.dart';

import 'package:presentation_site/ui/pages/home/sections/call_to_action_section.dart';
import 'package:presentation_site/ui/pages/home/sections/featured_work_section.dart';
import 'package:presentation_site/ui/pages/home/sections/hero_section.dart';
import 'package:presentation_site/ui/pages/home/sections/services_section.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return const .fragment(<Component>[
      HeroSection(),
      FeaturedWorkSection(),
      ServicesSection(),
      CallToActionSection(),
    ]);
  }
}

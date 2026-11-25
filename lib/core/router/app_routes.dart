import 'package:jaspr_router/jaspr_router.dart';

import '../../ui/pages/about/about_page.dart';
import '../../ui/pages/contact/contact_page.dart';
import '../../ui/pages/home/home_page.dart';
import '../../ui/pages/work/work_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String work = '/work';
  static const String about = '/about';
  static const String contact = '/contact';

  static final List<RouteBase> all = [
    Route(path: home, title: 'Home', builder: (context, state) => const HomePage()),
    Route(path: work, title: 'Work', builder: (context, state) => const WorkPage()),
    Route(path: about, title: 'About', builder: (context, state) => const AboutPage()),
    Route(path: contact, title: 'Contact', builder: (context, state) => const ContactPage()),
  ];
}

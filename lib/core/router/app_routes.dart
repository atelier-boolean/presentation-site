import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'package:presentation_site/ui/pages/about/about_page.dart';
import 'package:presentation_site/ui/pages/contact/contact_page.dart';
import 'package:presentation_site/ui/pages/home/home_page.dart';
import 'package:presentation_site/ui/pages/work/work_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String work = '/work';
  static const String about = '/about';
  static const String contact = '/contact';

  static final List<RouteBase> all = <RouteBase>[
    Route(
      path: home,
      title: 'Home',
      builder: (BuildContext context, RouteState state) => const HomePage(),
    ),
    Route(
      path: work,
      title: 'Work',
      builder: (BuildContext context, RouteState state) => const WorkPage(),
    ),
    Route(
      path: about,
      title: 'About',
      builder: (BuildContext context, RouteState state) => const AboutPage(),
    ),
    Route(
      path: contact,
      title: 'Contact',
      builder: (BuildContext context, RouteState state) => const ContactPage(),
    ),
  ];
}

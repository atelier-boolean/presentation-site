import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'package:presentation_site/ui/pages/about/about_page.dart';
import 'package:presentation_site/ui/pages/contact/contact_page.dart';
import 'package:presentation_site/ui/pages/home/home_page.dart';
import 'package:presentation_site/ui/pages/work/work_page.dart';

/// Every route and path of the site, in one place.
abstract final class AppRoutes {
  static const String home = '/';
  static const String work = '/work';
  static const String about = '/about';
  static const String contact = '/contact';

  /// Query keys `/contact` reads after a plain form post: the message was sent, or some
  /// fields need fixing.
  static const String contactSentQuery = 'sent';
  static const String contactInvalidQuery = 'invalid';
  static const String queryYes = '1';

  /// The pages in the header's and footer's navigation, in order.
  static const List<({String label, String path})> navigation =
      <({String label, String path})>[
        (label: 'Work', path: work),
        (label: 'About', path: about),
        (label: 'Contact', path: contact),
      ];

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
      builder: (BuildContext context, RouteState state) => ContactPage(
        sent: state.queryParams[contactSentQuery] == queryYes,
        invalid: state.queryParams[contactInvalidQuery] == queryYes,
      ),
    ),
  ];
}

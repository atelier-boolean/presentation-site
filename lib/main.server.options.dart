// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:presentation_site/core/theme/global_styles.dart'
    as _global_styles;
import 'package:presentation_site/ui/pages/home/sections/call_to_action_section.dart'
    as _call_to_action_section;
import 'package:presentation_site/ui/pages/home/sections/featured_work_section.dart'
    as _featured_work_section;
import 'package:presentation_site/ui/pages/home/sections/hero_section.dart'
    as _hero_section;
import 'package:presentation_site/ui/pages/home/sections/services_section.dart'
    as _services_section;
import 'package:presentation_site/ui/shared/card_grid.dart' as _card_grid;
import 'package:presentation_site/ui/shared/case_study_card.dart'
    as _case_study_card;
import 'package:presentation_site/ui/shared/empty_page.dart' as _empty_page;
import 'package:presentation_site/ui/shared/link_button.dart' as _link_button;
import 'package:presentation_site/ui/shared/page_container.dart'
    as _page_container;
import 'package:presentation_site/ui/shared/page_section.dart' as _page_section;
import 'package:presentation_site/ui/shared/site_header.dart' as _site_header;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  styles: () => [
    ..._global_styles.globalStyles,
    ..._call_to_action_section.CallToActionSection.styles,
    ..._featured_work_section.FeaturedWorkSection.styles,
    ..._hero_section.HeroSection.styles,
    ..._services_section.ServicesSection.styles,
    ..._card_grid.CardGrid.styles,
    ..._case_study_card.CaseStudyCard.styles,
    ..._empty_page.EmptyPage.styles,
    ..._link_button.LinkButton.styles,
    ..._page_container.PageContainer.styles,
    ..._page_section.PageSection.styles,
    ..._site_header.SiteHeader.styles,
  ],
);

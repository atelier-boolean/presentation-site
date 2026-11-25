// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_design_system/src/components/buttons/ds_link_button.dart'
    as _ds_link_button;
import 'package:jaspr_design_system/src/components/containers/ds_card.dart'
    as _ds_card;
import 'package:jaspr_design_system/src/components/containers/ds_media_placeholder.dart'
    as _ds_media_placeholder;
import 'package:jaspr_design_system/src/components/layout/ds_container.dart'
    as _ds_container;
import 'package:jaspr_design_system/src/components/layout/ds_grid.dart'
    as _ds_grid;
import 'package:jaspr_design_system/src/components/layout/ds_section.dart'
    as _ds_section;
import 'package:jaspr_design_system/src/components/navigation/ds_nav_link.dart'
    as _ds_nav_link;
import 'package:jaspr_design_system/src/components/navigation/ds_top_bar.dart'
    as _ds_top_bar;
import 'package:jaspr_design_system/src/styles/ds_base_styles.dart'
    as _ds_base_styles;
import 'package:presentation_site/ui/pages/home/sections/call_to_action_section.dart'
    as _call_to_action_section;
import 'package:presentation_site/ui/pages/home/sections/featured_work_section.dart'
    as _featured_work_section;
import 'package:presentation_site/ui/pages/home/sections/hero_section.dart'
    as _hero_section;
import 'package:presentation_site/ui/pages/home/sections/services_section.dart'
    as _services_section;

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
    ..._ds_base_styles.dsBaseStyles,
    ..._ds_link_button.DsLinkButton.styles,
    ..._ds_card.DsCard.styles,
    ..._ds_media_placeholder.DsMediaPlaceholder.styles,
    ..._ds_container.DsContainer.styles,
    ..._ds_grid.DsGrid.styles,
    ..._ds_section.DsSection.styles,
    ..._ds_nav_link.DsNavLink.styles,
    ..._ds_top_bar.DsTopBar.styles,
    ..._call_to_action_section.CallToActionSection.styles,
    ..._featured_work_section.FeaturedWorkSection.styles,
    ..._hero_section.HeroSection.styles,
    ..._services_section.ServicesSection.styles,
  ],
);

// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_design_system/src/theme/ds_theme.dart' as _ds_theme;
import 'package:presentation_site/ui/pages/contact/contact_form.dart'
    as _contact_form;

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
  clients: {
    _contact_form.ContactForm: ClientTarget<_contact_form.ContactForm>(
      'contact_form',
      params: __contact_formContactForm,
    ),
  },
  styles: () => [..._ds_theme.DsTheme.styles],
);

Map<String, Object?> __contact_formContactForm(_contact_form.ContactForm c) => {
  'sent': c.sent,
  'invalid': c.invalid,
};

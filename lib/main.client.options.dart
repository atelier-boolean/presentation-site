// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:presentation_site/ui/pages/contact/contact_form.dart'
    deferred as _contact_form;
import 'package:presentation_site/ui/pages/work/work_browser.dart'
    deferred as _work_browser;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'contact_form': ClientLoader(
      (p) => _contact_form.ContactForm(
        sent: p['sent'] as bool,
        invalid: p['invalid'] as bool,
      ),
      loader: _contact_form.loadLibrary,
    ),
    'work_browser': ClientLoader(
      (p) => _work_browser.WorkBrowser(),
      loader: _work_browser.loadLibrary,
    ),
  },
);

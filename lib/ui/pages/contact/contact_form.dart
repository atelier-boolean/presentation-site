import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:presentation_site/data/contact_content.dart';
import 'package:presentation_site/data/contact_rules.dart';
import 'package:presentation_site/data/models/contact_message.dart';
import 'package:presentation_site/data/repos/contact_repository.dart';
import 'package:presentation_site/ui/pages/contact/contact_state.dart';
import 'package:presentation_site/ui/pages/contact/contact_view_model.dart';

// Rows the message field shows before it scrolls.
const int _kMessageLines = 6;

/// The Contact form, run in the browser: it checks fields as the user goes, sends the
/// message and shows how it went.
///
/// Before its code runs, the form still posts to the server, which sends the user back
/// with [sent] or [invalid] set.
@client
class ContactForm extends StatefulComponent {
  final bool sent;
  final bool invalid;

  const ContactForm({this.sent = false, this.invalid = false, super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

/// Owns the view model and the HTTP client, and closes both.
class _ContactFormState extends State<ContactForm> {
  final http.Client _client = http.Client();
  late final ContactViewModel _viewModel = ContactViewModel(
    repository: ContactRepository(client: _client),
    initial: _initialState,
  );

  @override
  void dispose() {
    unawaited(_viewModel.close());
    _client.close();
    super.dispose();
  }

  @override
  Component build(BuildContext context) => VmBuilder<ContactState>(
    viewModel: _viewModel,
    builder: (BuildContext context, ContactState state) => switch (state) {
      ContactSent() => const _Thanks(),
      _ => _Form(state: state, onSubmit: _viewModel.send, onEdit: _viewModel.edit),
    },
  );

  /// Where the server's redirect left the user, after a plain form post.
  ContactState get _initialState => switch ((component.sent, component.invalid)) {
    (true, _) => const ContactSent(),
    (false, true) => const ContactRejected(<String, String>{}),
    (false, false) => const ContactEditing(),
  };
}

/// The fields, the error line and the send button.
class _Form extends StatelessComponent {
  final ContactState state;
  final ValueChanged<Map<String, String>> onSubmit;
  final VoidCallback onEdit;

  const _Form({required this.state, required this.onSubmit, required this.onEdit});

  @override
  Component build(BuildContext context) {
    final Map<String, String> errors = switch (state) {
      ContactRejected(:final Map<String, String> errors) => errors,
      _ => const <String, String>{},
    };
    final bool sending = state is ContactSending;
    return DsForm(
      action: ContactRepository.path,
      onSubmit: onSubmit,
      children: <Component>[
        DsFormField.text(
          labelText: ContactContent.nameLabel,
          name: ContactMessage.nameKey,
          autofill: .name,
          validator: ContactRules.name,
          errorText: errors[ContactMessage.nameKey],
          enabled: !sending,
          onChanged: _edited,
        ),
        DsFormField.email(
          labelText: ContactContent.emailLabel,
          name: ContactMessage.emailKey,
          hintText: ContactContent.emailHint,
          autofill: .email,
          validator: ContactRules.email,
          errorText: errors[ContactMessage.emailKey],
          enabled: !sending,
          onChanged: _edited,
        ),
        DsFormField.multiline(
          labelText: ContactContent.messageLabel,
          name: ContactMessage.messageKey,
          placeholder: ContactContent.messagePlaceholder,
          lines: _kMessageLines,
          validator: ContactRules.message,
          errorText: errors[ContactMessage.messageKey],
          enabled: !sending,
          onChanged: _edited,
        ),
        if (_failure case final String failure?) DsText.bodyMedium(failure, tone: .error),
        DsRow(
          children: <Component>[
            DsButton.primary(
              label: sending ? ContactContent.sending : ContactContent.send,
              submits: true,
              enabled: !sending,
            ),
          ],
        ),
      ],
    );
  }

  void _edited(String _) => onEdit();

  /// The message above the button when sending didn't work; null otherwise.
  String? get _failure => switch (state) {
    ContactRejected(:final Map<String, String> errors) when errors.isEmpty =>
      ContactContent.invalid,
    ContactFailed(reason: .network) => ContactContent.networkError,
    ContactFailed(reason: .server) => ContactContent.serverError,
    _ => null,
  };
}

/// Shown once the message was sent.
class _Thanks extends StatelessComponent {
  const _Thanks();

  @override
  Component build(BuildContext context) => const DsColumn.start(
    children: <Component>[
      DsText.headlineSmall(ContactContent.thanksTitle, tag: .p),
      DsText.bodyLarge(ContactContent.thanksText, tone: .muted),
    ],
  );
}

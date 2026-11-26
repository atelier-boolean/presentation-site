import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/models/contact_message.dart';

/// What a contact message must look like. The form checks it in the browser and the
/// server checks it again, with the same validators.
abstract final class ContactRules {
  static const int nameMaxLength = 100;
  static const int messageMinLength = 10;
  static const int messageMaxLength = 2000;

  static const DsValidator name = DsAllValidator(<DsValidator>[
    DsRequiredValidator(message: 'Tell me your name.'),
    DsMaxLengthValidator(nameMaxLength),
  ]);

  static const DsValidator email = DsAllValidator(<DsValidator>[
    DsRequiredValidator(message: 'Add your email, so I can reply.'),
    DsEmailValidator(),
  ]);

  static const DsValidator message = DsAllValidator(<DsValidator>[
    DsRequiredValidator(message: 'Write a message.'),
    DsMinLengthValidator(messageMinLength),
    DsMaxLengthValidator(messageMaxLength),
  ]);

  /// Each field's error, by key; empty when the message is fine.
  static Map<String, String> errorsOf(ContactMessage contact) => <String, String>{
    ContactMessage.nameKey: ?name(contact.name),
    ContactMessage.emailKey: ?email(contact.email),
    ContactMessage.messageKey: ?message(contact.message),
  };
}

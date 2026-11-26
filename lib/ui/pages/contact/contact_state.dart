import 'package:presentation_site/data/repos/contact_send_result.dart';

/// What the Contact form shows. Equal states are equal values, so the view model skips
/// repeats.
sealed class ContactState {
  const ContactState();
}

/// Filling in the form.
final class ContactEditing extends ContactState {
  const ContactEditing();

  @override
  bool operator ==(Object other) => other is ContactEditing;

  @override
  int get hashCode => (ContactEditing).hashCode;
}

/// The message is on its way.
final class ContactSending extends ContactState {
  const ContactSending();

  @override
  bool operator ==(Object other) => other is ContactSending;

  @override
  int get hashCode => (ContactSending).hashCode;
}

/// The server took the message.
final class ContactSent extends ContactState {
  const ContactSent();

  @override
  bool operator ==(Object other) => other is ContactSent;

  @override
  int get hashCode => (ContactSent).hashCode;
}

/// The server found problems with some fields.
final class ContactRejected extends ContactState {
  /// Each field's error, by `ContactMessage` key. Empty when the server named none.
  final Map<String, String> errors;

  const ContactRejected(this.errors);

  @override
  bool operator ==(Object other) =>
      other is ContactRejected &&
      other.errors.length == errors.length &&
      errors.entries.every(
        (MapEntry<String, String> entry) => other.errors[entry.key] == entry.value,
      );

  @override
  int get hashCode => Object.hashAllUnordered(
    errors.entries.map(
      (MapEntry<String, String> entry) => Object.hash(entry.key, entry.value),
    ),
  );
}

/// The message didn't get through.
final class ContactFailed extends ContactState {
  final ContactFailure reason;

  const ContactFailed(this.reason);

  @override
  bool operator ==(Object other) => other is ContactFailed && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;
}

/// How sending a contact message went. A sealed family, so every outcome is handled.
sealed class ContactSendResult {
  const ContactSendResult();
}

/// The server took the message.
final class ContactSendSucceeded extends ContactSendResult {
  const ContactSendSucceeded();
}

/// The server found problems with some fields.
final class ContactSendRejected extends ContactSendResult {
  /// Each field's error, by `ContactMessage` key. Can be empty when the server named
  /// none.
  final Map<String, String> errors;

  const ContactSendRejected(this.errors);
}

/// The message didn't get through.
final class ContactSendFailed extends ContactSendResult {
  final ContactFailure reason;

  const ContactSendFailed(this.reason);
}

/// Why a message didn't get through.
enum ContactFailure {
  /// The server couldn't be reached, for example when offline.
  network,

  /// The server answered with an error, or with something unreadable.
  server,
}

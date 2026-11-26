/// A message sent from the Contact page: the same fields in the form, the JSON and the
/// server.
final class ContactMessage {
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String messageKey = 'message';

  final String name;
  final String email;
  final String message;

  const ContactMessage({required this.name, required this.email, required this.message});

  /// From a form's or a request's values, trimmed. Missing or non-text values are empty.
  factory ContactMessage.fromMap(Map<String, Object?> values) => ContactMessage(
    name: _text(values[nameKey]),
    email: _text(values[emailKey]),
    message: _text(values[messageKey]),
  );

  @override
  bool operator ==(Object other) =>
      other is ContactMessage &&
      other.name == name &&
      other.email == email &&
      other.message == message;

  @override
  int get hashCode => Object.hash(name, email, message);

  /// The fields by key, for a JSON request.
  Map<String, String> toJson() => <String, String>{
    nameKey: name,
    emailKey: email,
    messageKey: message,
  };

  static String _text(Object? value) => value is String ? value.trim() : '';
}

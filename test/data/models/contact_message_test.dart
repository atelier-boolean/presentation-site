import 'package:presentation_site/data/models/contact_message.dart';
import 'package:test/test.dart';

void main() {
  group('ContactMessage.fromMap', () {
    test('reads and trims every field', () {
      // Arrange
      const Map<String, Object?> values = <String, Object?>{
        'name': ' Ada ',
        'email': 'ada@example.com',
        'message': 'Hello there',
      };

      // Act
      final ContactMessage message = ContactMessage.fromMap(values);

      // Assert
      expect(
        message,
        const ContactMessage(
          name: 'Ada',
          email: 'ada@example.com',
          message: 'Hello there',
        ),
      );
    });

    test('leaves missing fields empty', () {
      // Arrange
      const Map<String, Object?> values = <String, Object?>{};

      // Act
      final ContactMessage message = ContactMessage.fromMap(values);

      // Assert
      expect(message, const ContactMessage(name: '', email: '', message: ''));
    });

    test('treats a value that is not text as empty', () {
      // Arrange
      const Map<String, Object?> values = <String, Object?>{'name': 42, 'email': null};

      // Act
      final ContactMessage message = ContactMessage.fromMap(values);

      // Assert
      expect(<String>[message.name, message.email], <String>['', '']);
    });
  });

  group('toJson', () {
    test('gives every field by key', () {
      // Arrange
      const ContactMessage message = ContactMessage(
        name: 'Ada',
        email: 'a@b.co',
        message: 'Hi',
      );

      // Act
      final Map<String, String> json = message.toJson();

      // Assert
      expect(json, <String, String>{'name': 'Ada', 'email': 'a@b.co', 'message': 'Hi'});
    });

    test('reads back into an equal message', () {
      // Arrange
      const ContactMessage message = ContactMessage(
        name: 'Ada',
        email: 'a@b.co',
        message: 'Hi',
      );

      // Act
      final ContactMessage copy = ContactMessage.fromMap(message.toJson());

      // Assert
      expect(copy, message);
    });

    test('keeps empty fields', () {
      // Arrange
      const ContactMessage message = ContactMessage(name: '', email: '', message: '');

      // Act
      final Map<String, String> json = message.toJson();

      // Assert
      expect(json.values, everyElement(isEmpty));
    });
  });
}

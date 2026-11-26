import 'package:flutter_test/flutter_test.dart';
import 'package:presentation_site/data/contact_rules.dart';
import 'package:presentation_site/data/models/contact_message.dart';

void main() {
  group('errorsOf', () {
    test('is empty for a good message', () {
      // Arrange
      const ContactMessage message = ContactMessage(
        name: 'Ada',
        email: 'ada@example.com',
        message: 'I would like a new website.',
      );

      // Act
      final Map<String, String> errors = ContactRules.errorsOf(message);

      // Assert
      expect(errors, isEmpty);
    });

    test('names every empty field', () {
      // Arrange
      const ContactMessage message = ContactMessage(name: '', email: '', message: '');

      // Act
      final Map<String, String> errors = ContactRules.errorsOf(message);

      // Assert
      expect(errors, <String, String>{
        'name': 'Tell me your name.',
        'email': 'Add your email, so I can reply.',
        'message': 'Write a message.',
      });
    });

    test('flags a message that is too short', () {
      // Arrange
      const ContactMessage message = ContactMessage(
        name: 'Ada',
        email: 'ada@example.com',
        message: 'Hi',
      );

      // Act
      final Map<String, String> errors = ContactRules.errorsOf(message);

      // Assert
      expect(errors.keys, <String>['message']);
    });
  });
}

import 'package:presentation_site/data/repos/contact_send_result.dart';
import 'package:presentation_site/ui/pages/contact/contact_state.dart';
import 'package:test/test.dart';

void main() {
  group('ContactRejected', () {
    test('equals another with the same errors in any order', () {
      // Arrange
      final ContactRejected first = ContactRejected(
        Map<String, String>.of(<String, String>{'a': '1', 'b': '2'}),
      );
      final ContactRejected second = ContactRejected(
        Map<String, String>.of(<String, String>{'b': '2', 'a': '1'}),
      );

      // Act
      final bool equal = first == second && first.hashCode == second.hashCode;

      // Assert
      expect(equal, isTrue);
    });

    test('differs when an error differs', () {
      // Arrange
      const ContactRejected first = ContactRejected(<String, String>{'a': '1'});
      const ContactRejected second = ContactRejected(<String, String>{'a': '2'});

      // Act
      final bool equal = first == second;

      // Assert
      expect(equal, isFalse);
    });

    test('differs when one has more errors', () {
      // Arrange
      const ContactRejected first = ContactRejected(<String, String>{});
      const ContactRejected second = ContactRejected(<String, String>{'a': '1'});

      // Act
      final bool equal = first == second;

      // Assert
      expect(equal, isFalse);
    });
  });

  group('ContactFailed', () {
    test('equals another with the same reason', () {
      // Arrange
      final ContactFailed first = ContactFailed(ContactFailure.values.first);

      // Act
      final bool equal = first == ContactFailed(ContactFailure.values.first);

      // Assert
      expect(equal, isTrue);
    });

    test('differs when the reason differs', () {
      // Arrange
      const ContactFailed network = ContactFailed(ContactFailure.network);

      // Act
      final bool equal = network == const ContactFailed(ContactFailure.server);

      // Assert
      expect(equal, isFalse);
    });
  });

  group('states without data', () {
    test('equal any instance of the same kind', () {
      // Arrange
      // Tear-offs build new, non-const instances.
      final List<ContactState> built = <ContactState Function()>[
        ContactEditing.new,
        ContactSending.new,
        ContactSent.new,
      ].map((ContactState Function() create) => create()).toList();

      // Act
      final bool equal =
          built[0] == const ContactEditing() &&
          built[1] == const ContactSending() &&
          built[2] == const ContactSent();

      // Assert
      expect(equal, isTrue);
    });

    test('differ from each other', () {
      // Arrange
      const ContactState editing = ContactEditing();

      // Act
      final bool equal = editing == const ContactSent();

      // Assert
      expect(equal, isFalse);
    });
  });
}

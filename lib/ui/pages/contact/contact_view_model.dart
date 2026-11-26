import 'package:jaspr_design_system/jaspr_design_system.dart';

import 'package:presentation_site/data/models/contact_message.dart';
import 'package:presentation_site/data/repos/contact_repository.dart';
import 'package:presentation_site/data/repos/contact_send_result.dart';
import 'package:presentation_site/ui/pages/contact/contact_state.dart';

/// Sends the Contact form and says how it went.
final class ContactViewModel extends RxViewModel<ContactState> {
  final ContactRepository _repository;

  /// [initial] is `ContactSent` or `ContactRejected` when the server sent the user back
  /// after a plain form post.
  ContactViewModel({
    required ContactRepository repository,
    ContactState initial = const ContactEditing(),
  }) : _repository = repository,
       super(initial);

  /// Sends the form's values. Ignored while a message is already on its way.
  Future<void> send(Map<String, String> values) async {
    if (state is ContactSending) return;
    emit(const ContactSending());
    final ContactSendResult result = await _repository.send(
      ContactMessage.fromMap(values),
    );
    if (isClosed) return;
    emit(switch (result) {
      ContactSendSucceeded() => const ContactSent(),
      ContactSendRejected(:final Map<String, String> errors) => ContactRejected(errors),
      ContactSendFailed(:final ContactFailure reason) => ContactFailed(reason),
    });
  }

  /// Clears a rejection or failure once the user edits the form again.
  void edit() {
    if (state case ContactRejected() || ContactFailed()) emit(const ContactEditing());
  }
}

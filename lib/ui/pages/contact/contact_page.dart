import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';
import 'package:presentation_site/data/contact_content.dart';
import 'package:presentation_site/ui/pages/contact/contact_form.dart';

/// The Contact page: a short intro and the form.
///
/// [sent] and [invalid] come from the address after a plain form post, before the page's
/// code ran.
class ContactPage extends StatelessComponent {
  final bool sent;
  final bool invalid;

  const ContactPage({this.sent = false, this.invalid = false, super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: <Component>[
        DsColumn.start(
          spacing: DsSpacing.x8,
          style: const DsStyle(maxWidth: DsWidth.x2l),
          children: <Component>[
            const DsColumn.start(
              children: <Component>[
                DsText.displaySmall(ContactContent.title),
                DsText.bodyLarge(ContactContent.intro, tone: .muted),
              ],
            ),
            ContactForm(sent: sent, invalid: invalid),
          ],
        ),
      ],
    );
  }
}

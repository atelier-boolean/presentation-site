/// The placeholder persona and the texts the header and footer share.
abstract final class SiteContent {
  static const String name = 'Mara Ionescu';
  static const String role = 'UI/UX Designer';

  static const String pagesTitle = 'Pages';
  static const String contactTitle = 'Contact';

  // The persona is fictional, so the address uses a domain reserved for examples.
  static const String email = 'hello@maraionescu.example';
  static const String emailHref = 'mailto:$email';

  static const String copyright = '© 2026 $name';
}

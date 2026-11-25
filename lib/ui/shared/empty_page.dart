import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

// A page with only its title, for pages not built yet.
class EmptyPage extends StatelessComponent {
  final String title;

  const EmptyPage({required this.title, super.key});

  @override
  Component build(BuildContext context) {
    return DsSection.plain(
      children: [
        h1([.text(title)]),
      ],
    );
  }
}

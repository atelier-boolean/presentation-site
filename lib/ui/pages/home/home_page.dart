import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return const section([
      h1([.text('Home')]),
    ]);
  }
}

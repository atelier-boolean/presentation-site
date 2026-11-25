library;

import 'package:jaspr/client.dart';

import 'package:presentation_site/main.client.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);
  runApp(const ClientApp());
}

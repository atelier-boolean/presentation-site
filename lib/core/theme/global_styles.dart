import 'package:jaspr/dom.dart';

@css
List<StyleRule> get globalStyles => [
  css('html, body').styles(
    width: 100.percent,
    minHeight: 100.vh,
    padding: .zero,
    margin: .zero,
    fontFamily: FontFamilies.sansSerif,
  ),
];

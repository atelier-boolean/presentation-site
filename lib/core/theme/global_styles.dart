import 'package:jaspr/dom.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

const double _kLineHeight = 1.5;
const double _kHeadingLineHeight = 1.15;

@css
List<StyleRule> get globalStyles => [
  css('*').styles(boxSizing: .borderBox),
  css('html, body').styles(
    width: 100.percent,
    minHeight: 100.vh,
    padding: .zero,
    margin: .zero,
    color: AppColors.text,
    fontFamily: FontFamilies.sansSerif,
    fontSize: AppSizes.fontBody,
    lineHeight: const Unit.em(_kLineHeight),
    backgroundColor: AppColors.background,
  ),
  css('h1, h2, h3').styles(margin: .zero, lineHeight: const Unit.em(_kHeadingLineHeight)),
  css('h1').styles(fontSize: AppSizes.fontDisplay),
  css('h2').styles(fontSize: AppSizes.fontHeadline),
  css('h3').styles(fontSize: AppSizes.fontTitle),
  css('p').styles(margin: .zero),
  css.media(const MediaQuery.screen(maxWidth: AppSizes.phoneMaxWidth), [
    css('h1').styles(fontSize: AppSizes.fontDisplayPhone),
  ]),
];

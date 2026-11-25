import 'package:jaspr/dom.dart';

// Spacing steps count 4px grid units, like the Flutter design system: s400 = 16px.
abstract final class AppSizes {
  static const Unit s100 = Unit.pixels(4);
  static const Unit s200 = Unit.pixels(8);
  static const Unit s300 = Unit.pixels(12);
  static const Unit s400 = Unit.pixels(16);
  static const Unit s600 = Unit.pixels(24);
  static const Unit s800 = Unit.pixels(32);
  static const Unit s1200 = Unit.pixels(48);
  static const Unit s1600 = Unit.pixels(64);
  static const Unit s2400 = Unit.pixels(96);

  static const Unit radiusMedium = Unit.pixels(8);
  static const Unit radiusLarge = Unit.pixels(16);
  static const Unit radiusPill = Unit.pixels(999);
  static const Unit borderThin = Unit.pixels(1);

  static const Unit contentMaxWidth = Unit.pixels(1120);
  static const Unit textMaxWidth = Unit.pixels(640);
  static const Unit headerHeight = Unit.pixels(64);

  // Below this width the layout switches to phone.
  static const Unit phoneMaxWidth = Unit.pixels(640);

  static const Unit fontBody = Unit.rem(1);
  static const Unit fontSmall = Unit.rem(0.875);
  static const Unit fontTitle = Unit.rem(1.25);
  static const Unit fontHeadline = Unit.rem(2);
  static const Unit fontDisplay = Unit.rem(3.5);
  static const Unit fontDisplayPhone = Unit.rem(2.5);
}

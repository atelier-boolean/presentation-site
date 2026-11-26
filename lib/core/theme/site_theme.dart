import 'package:jaspr/dom.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

// Cosmic Window's palette (the Flutter design system's `DsPalette`), deepened to
// near-black.
const Color _kNight = Color('#0B0D12');
const Color _kSurface = Color('#12151C');
const Color _kSurfaceRaised = Color('#1A1E27');
const Color _kOffWhite = Color('#F5F5F5');
const Color _kMutedSkyBlue = Color('#8FA3C2');
const Color _kSoftPeriwinkle = Color('#C4B7D6');
const Color _kPeriwinkleLight = Color('#D6CCE3');
const Color _kVibrantMagenta = Color('#E7549A');
// The Flutter design system's dark error and disabled colours.
const Color _kDustyRose = Color('#CF6679');
const Color _kDusk = Color('#2E3544');
const Color _kSlateGrey = Color('#5C5C5C');

// Hairlines and tints: white at low opacity, so they sit on any dark surface.
const Color _kHairline = Color.rgba(255, 255, 255, 0.08);
const Color _kHairlineStrong = Color.rgba(255, 255, 255, 0.16);
const Color _kTint = Color.rgba(255, 255, 255, 0.02);
const Color _kTintHover = Color.rgba(255, 255, 255, 0.06);
const Color _kBarFill = Color.rgba(11, 13, 18, 0.72);
const Color _kTopLight = Color.rgba(196, 183, 214, 0.08);

// The one light source: a soft glow from the top of the page, gone by a quarter of the
// way down.
const List<double> _kTopLightStops = <double>[0, 0.25];

// The Flutter design system's `DsBlur.frosted`.
const Filter _kFrosted = Filter.blur(Unit.pixels(8));

// A 1px highlight along a card's top edge when it is hovered.
const BoxShadow _kTopHighlight = BoxShadow.inset(
  offsetX: Unit.zero,
  offsetY: Unit.pixels(1),
  color: _kHairlineStrong,
);

// Headings: semibold, slightly tighter, as large type is set today.
const DsStyle _kHeading = DsStyle(fontWeight: .w600, letterSpacing: Unit.em(-0.02));

const FontFamily _kInter = FontFamily.list(<FontFamily>[
  FontFamily('Inter'),
  FontFamilies.sansSerif,
]);

// The site's theme: Cosmic Window's colours, flat near-black surfaces with hairline
// borders, one soft light from the top, and Inter.
final DsThemeData siteTheme = DsThemeData(
  colors: const DsColorsData(
    background: _kNight,
    surface: _kSurface,
    placeholder: _kSurfaceRaised,
    border: _kHairline,
    text: _kOffWhite,
    textMuted: _kMutedSkyBlue,
    primary: _kSoftPeriwinkle,
    primaryHover: _kPeriwinkleLight,
    onPrimary: _kNight,
    error: _kDustyRose,
    surfaceDisabled: _kDusk,
    textDisabled: _kSlateGrey,
  ),
  fonts: const DsFontsData(body: _kInter, heading: _kInter),
  page: const DsStyle(
    gradient: DsGradient.linear(
      colors: <Color>[_kTopLight, Colors.transparent],
      stops: _kTopLightStops,
    ),
  ),
  plainSection: const DsStyle(background: Colors.transparent),
  tintedSection: const DsStyle(background: _kTint),
  topBar: const DsStyle(
    background: _kBarFill,
    borderColor: _kHairline,
    backdropFilter: _kFrosted,
  ),
  navLink: const DsStyle(borderColor: Colors.transparent),
  card: const DsStyle(background: _kSurface, borderColor: _kHairline),
  linkedCard: const DsStyle(
    background: _kSurface,
    borderColor: _kHairline,
    hover: DsStyle(borderColor: _kHairlineStrong, shadow: _kTopHighlight),
  ),
  mediaPlaceholder: const DsStyle(background: _kSurfaceRaised),
  primaryButton: DsStyle(
    background: _kSoftPeriwinkle,
    foreground: _kNight,
    borderColor: _kSoftPeriwinkle,
    radius: DsRadius.lg,
    hover: const DsStyle(background: _kPeriwinkleLight, borderColor: _kPeriwinkleLight),
  ),
  secondaryButton: DsStyle(
    background: Colors.transparent,
    foreground: _kOffWhite,
    borderColor: _kHairlineStrong,
    radius: DsRadius.lg,
    hover: const DsStyle(background: _kTintHover),
  ),
  displayLarge: _kHeading,
  displayMedium: _kHeading,
  displaySmall: _kHeading,
  headlineLarge: _kHeading,
  headlineMedium: _kHeading,
  headlineSmall: _kHeading,
  titleLarge: const DsStyle(fontWeight: .w500),
  // Magenta, Cosmic Window's highlight, only as a small accent: labels and the hero's
  // role.
  primaryText: const DsStyle(foreground: _kVibrantMagenta),
);

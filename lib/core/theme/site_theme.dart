import 'package:jaspr/dom.dart';
import 'package:jaspr_design_system/jaspr_design_system.dart';

// Cosmic Window's dark palette (the Flutter design system's `DsPalette`).
const Color _kInkBlack = Color('#0F1218');
const Color _kMidnight = Color('#171B24');
const Color _kDusk = Color('#2E3544');
const Color _kDeepOceanBlue = Color('#2A3C5E');
const Color _kOffWhite = Color('#F5F5F5');
const Color _kMutedSkyBlue = Color('#8FA3C2');
const Color _kSoftPeriwinkle = Color('#C4B7D6');
const Color _kVibrantMagenta = Color('#E7549A');

// Glass: translucent fills and edges over the space background, as the app's `surfaceCard` (slate at 20%).
const Color _kGlassFill = Color.rgba(92, 92, 92, 0.2);
const Color _kGlassFillHover = Color.rgba(255, 255, 255, 0.12);
const Color _kGlassTint = Color.rgba(255, 255, 255, 0.03);
const Color _kGlassEdge = Color.rgba(196, 183, 214, 0.25);
const Color _kGlassEdgeStrong = Color.rgba(196, 183, 214, 0.4);
const Color _kBarFill = Color.rgba(15, 18, 24, 0.6);
const Color _kBarEdge = Color.rgba(42, 60, 94, 0.6);
const Color _kDepthShadow = Color.rgba(0, 0, 0, 0.35);
const Color _kPeriwinkleGlow = Color.rgba(196, 183, 214, 0.35);
const Color _kMagentaGlow = Color.rgba(231, 84, 154, 0.35);
const Color _kMagentaGlowStrong = Color.rgba(231, 84, 154, 0.55);

// The Flutter design system's `DsBlur`.
const Filter _kFrosted = Filter.blur(Unit.pixels(8));
const Filter _kStrongBlur = Filter.blur(Unit.pixels(16));

const Angle _kDiagonal = Angle.deg(135);
const List<double> _kSpaceStops = <double>[0, 0.7];

const BoxShadow _kCardShadow = BoxShadow(
  offsetX: Unit.zero,
  offsetY: Unit.pixels(8),
  blur: Unit.pixels(32),
  color: _kDepthShadow,
);
const BoxShadow _kCardGlow = BoxShadow(
  offsetX: Unit.zero,
  offsetY: Unit.zero,
  blur: Unit.pixels(24),
  color: _kPeriwinkleGlow,
);
const BoxShadow _kButtonGlow = BoxShadow(
  offsetX: Unit.zero,
  offsetY: Unit.pixels(8),
  blur: Unit.pixels(24),
  color: _kMagentaGlow,
);
const BoxShadow _kButtonGlowStrong = BoxShadow(
  offsetX: Unit.zero,
  offsetY: Unit.pixels(10),
  blur: Unit.pixels(32),
  color: _kMagentaGlowStrong,
);

const DsStyle _kGlassCard = DsStyle(
  background: _kGlassFill,
  borderColor: _kGlassEdge,
  backdropFilter: _kFrosted,
  shadow: _kCardShadow,
);

// The site's theme: Cosmic Window's colours, with glass surfaces and glowing buttons over a space background.
final DsThemeData siteTheme = DsThemeData(
  // Every value below is a compile-time constant; only `merge` needs the theme to be final.
  colors: const DsColorsData(
    background: _kInkBlack,
    surface: _kMidnight,
    placeholder: _kDusk,
    border: _kDeepOceanBlue,
    text: _kOffWhite,
    textMuted: _kMutedSkyBlue,
    primary: _kSoftPeriwinkle,
    primaryHover: _kOffWhite,
    onPrimary: _kInkBlack,
  ),
  page: const DsStyle(
    gradient: DsGradient.radial(
      colors: <Color>[_kDeepOceanBlue, _kInkBlack],
      stops: _kSpaceStops,
    ),
  ),
  plainSection: const DsStyle(background: Colors.transparent),
  tintedSection: const DsStyle(background: _kGlassTint),
  topBar: const DsStyle(
    background: _kBarFill,
    borderColor: _kBarEdge,
    backdropFilter: _kStrongBlur,
  ),
  navLink: const DsStyle(borderColor: Colors.transparent),
  card: _kGlassCard,
  linkedCard: _kGlassCard.merge(
    const DsStyle(
      hover: DsStyle(borderColor: _kSoftPeriwinkle, shadow: _kCardGlow),
    ),
  ),
  mediaPlaceholder: const DsStyle(
    gradient: DsGradient.linear(
      colors: <Color>[_kDeepOceanBlue, _kDusk],
      angle: _kDiagonal,
    ),
  ),
  primaryButton: const DsStyle(
    background: _kSoftPeriwinkle,
    gradient: DsGradient.linear(
      colors: <Color>[_kSoftPeriwinkle, _kVibrantMagenta],
      angle: _kDiagonal,
    ),
    foreground: _kInkBlack,
    borderColor: Colors.transparent,
    shadow: _kButtonGlow,
    hover: DsStyle(shadow: _kButtonGlowStrong),
  ),
  secondaryButton: const DsStyle(
    background: _kGlassFill,
    foreground: _kOffWhite,
    borderColor: _kGlassEdgeStrong,
    backdropFilter: _kFrosted,
    hover: DsStyle(background: _kGlassFillHover),
  ),
);

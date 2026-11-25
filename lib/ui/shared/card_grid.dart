import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../core/theme/app_sizes.dart';

const Unit _kMinColumnWidth = Unit.pixels(260);

// As many equal columns as fit, each at least _kMinColumnWidth; one column on phones.
class CardGrid extends StatelessComponent {
  const CardGrid({required this.children, super.key});

  final List<Component> children;

  @override
  Component build(BuildContext context) => div(classes: 'card-grid', children);

  @css
  static List<StyleRule> get styles => [
    css('.card-grid').styles(
      display: .grid,
      gridTemplate: const GridTemplate(
        columns: GridTracks([
          GridTrack.repeat(TrackRepeat.autoFit, [
            GridTrack(TrackSize.minmax(TrackSize(_kMinColumnWidth), TrackSize.fr(1))),
          ]),
        ]),
      ),
      gap: const .all(AppSizes.s600),
    ),
  ];
}

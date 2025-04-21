Welcome to FLUF, the package that provides convenience functions to develop your Flutter app.
FLUF means Flutter Leveraging User Functions.

## Features

### Animated Widgets

These widgets extend from `BaseAnimatedWidget` which holds a Flutter `AnimationController`.
- `FlingWidget`
- `RevealWidget`

### Extensions

#### `AsyncSnapshot` extensions:
- `isReady()`: shortcut for snapshot's connection state == `done` and snapshot has data
- `isLoading()`: shortcut for snapshot's connection state == `waiting`
- `isComplete()`: 

#### `BoxConstraints` extensions:
- `areMaxConstraintsValid`: maximum dimensions are finite
- `areMinConstraintsValid`: minimum dimensions are finite

#### `BuildContext` extensions:
- `theme` : shortcut for `Theme.of(context)`
- `textTheme` : shortcut for `Theme.of(context).textTheme`
- `colorScheme`: shortcut for `Theme.of(context).colorScheme`
- `navigator`: shortcut for `Navigator.of(BuildContext)`
- `locale`: shortcut for `Localizations.localeOf(this)`
- `pop()`: shortcut for `Navigator.of(BuildContext).pop()`
- `fadeTo(Widget)`: push and replace current widget with given `Widget` with fade animation
- `slideTo(Widget, Duration, Axis)`: push `Widget` with slide animation
- `revealFrom(Widget, Duration, Alignment)`: reveal (scale and translate) `Widget` from `Alignment` corner
- `showSnackBar(Widget, bool? floating)` : show a SnackBar using context`s ScaffoldMessenger
- `brightness` : platform brightness setting
- `isDarkBrightness` : if platform brightness is dark
- `orientation` : orientation
- `mediaQuerySize` : size

#### `Color` extensions:
- `minusDelta(int)`: color with subtracted `delta` in each of RGB values
- `plusDelta(int)`: color with added `delta` in each of RGB values
- `asPressableProperty()`: `WidgetStateProperty` with reduced opacity for pressed state
- `deltaWithBrightnessOf(BuildContext context, int delta, bool? inverse)`: apply delta depending on platform brightness setting

#### `Duration` extensions:
- `hms()`: format as HH:MM:SS String

#### `double` extensions:
- `seconds`: equivalent `Duration` object from seconds value

#### `GlobalKey` extensions:
- `center`: global center position as `Offset?` of this key's `Widget` 

#### `int` extensions:
- `milliseconds`: equivalent `Duration` object from milliseconds value
- `ms`: shortcut for `milliseconds`
- `seconds`: equivalent `Duration` object from seconds value

#### `List` extensions:
- `getMainDiagonalIntersections()`: indexes list of diagonals intersecting the main diagonal, if the list can be represented as a 2 dimensional array, returns `null` otherwise. E.g: `[0, 1, 2, 3].getMainDiagonalIntersections()` returns `[[0], [1,2], [3]]`.
- `getHorizontalIntersections()`: indexes list of horizontal intersections of the 2 dimensional array.
- `containsValue`: perform value-based comparison to look for an item in a list, instead of reference-based.

- `findClosestIndex(double value)`: returns index of closest item to `value`, or `-1` if no item can't be found
- `findContainingIndexes(double target)`: finds indexes of items where `value` lies in between 

#### `TimeOfDay` extensions:
- `minutes` : as minutes

### Object scope extensions:
- `let(R Function(T))`: invoke lambda passing receiver object and return lambda's result
- `also(void Function(T))`: invoke lambda passing receiver object, and return this object
- `asWidgetStateProperty(Map<WidgetState, T>)`: map object as `WidgetStateProperty`
- `logType(String)`: log a message using `dart:developer`'s `log` with `name` attribute set to object's `runtimeType`
- `tryCast<T>` : attempt cast to type, returns `null` on failure

#### `String` extensions:
- `toParagraph()`: map to `dart:ui` `Paragraph`
- `async color()`: compute average color (for emojis) 
- `sizeOfStyle(TextStyle?)`: compute size spanned by this string with given style 
- `captialize` : make first character upper case
- `captitalizeAll` : make first character of all space-separated items uppercase
#### `TextStyle` extensions:
- `bold()`: copy of this TextStlye with bold font weight
- `toUiTextStyle()`: convert a Theme's text style to a Dart `ui` package's `TextStyle`

#### `ScrollController` extensions:
- `progress`: current progress from 0.0 to 1.0.

#### `PageController` extensions:
- `atomicPage`: current page index as non-nullable integer

#### `Route` extensions:
- `isRoot`: if the current route name denotes to '/'

#### `WidgetExtensions` extensions:
- `addSemantics(label, hint, value)`: wrap widget into a Semantics widget
- `toHero(Object? tag)` : wrap into `Hero`. Do nothing and return this if tag is null.
- `toMaterialHero(Object? tag)` : wrap into a transparent `Material` widget, and into `Hero`. 
  This extension is useful for `Text` widgets with different styles, or scenarri where the Hero transition
  underlines the animated widget with yellow lines, indicating that the source and target widgets differ.
  Do nothing and return this if tag is null.

### UI

#### `CustomPainter`
- `RayPainter`
- `WaterfallPainter` : Emoji grid painter with waterfall animation

### Helpers

#### `FutureHolder` : 
- Container for `Future`-s with ability to dispose them all on demand

#### `WidgetBuilderFactory`:
- `buildLoadingState`
- `buildInfoState`

### Repositories

#### `AssetRepo`:
- `loadJsonList`

#### `ColorRepo`: see `ColorRepoMixin`

### `DateTimeRepo`:
- `now`: now as `DateTime` according to local timezone
- `nowDate`: same as `now` with all time-related fields set to 0
- `nowUtc`: now as UTC `DateTime` 
- `epochMs`: elapsed milliseconds since Unix epoch

#### `ThemeRepo`:
- `lightTheme()`: Material 3 light theme data
- `darkTheme()`: Material 3 dark theme data

### Mixins

#### `AnimateOnPressMixin`
 - Set a value (origin 1.0) back and forth from `press()` to `release()` mixin calls. E.g : Create a widget that animates when it is pressed, and animates back once released.

#### `ColorRepoMixin`:
- `compute(Characters)`: compute and cache average color of each emoji from given characters
- `get(String)`: get given emoji's color, or null

#### `HapticFeedbackMixin`
- `lightHapticFeedback()`
- `mediumHapticFeedback()`
- `heavyHapticFeedback()`
- `selectionHapticFeedback()`
- `vibrateFeedback()`

### Widgets

- `Shimmer` : manages a shimmering shine onto multiple `ShimmerLoadingWidget`
- `ShimmerLoadingWidget` : a wrapper for a single widget with a shimmering loading state

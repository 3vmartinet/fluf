<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Welcome to FLUF, the package that provides convenience functions to develop your Flutter app.
FLUF means Flutter Leveraging User Functions.

## Features

### Extensions

#### `BuildContext` extensions:
- `theme` : shortcut for `Theme.of(context)`
- `textTheme` : shortcut for `Theme.of(context).textTheme`
- `colorScheme`: shortcut for `Theme.of(context).colorScheme`
- `navigator`: shortcut for `Navigator.of(BuildContext)`
- `pop()`: shortcut for `Navigator.of(BuildContext).pop()`
- `fadeTo(Widget)`: push and replace current widget with given `Widget` with fade animation
- `navigateTo(Widget)`: push given `Widget` with slide animation
- `showSnackBar(Widget)` : show a SnackBar with given `content`, using context`s ScaffoldMessenger

#### `Color` extensions:
- `minusDelta(int)`: color with subtracted `delta` in each of RGB values
- `plusDelta(int)`: color with added `delta` in each of RGB values
- `asPressableProperty()`: `WidgetStateProperty` with reduced opacity for pressed state

#### `AsyncSnapshot` extensions:
- `isReady()`: shortcut for snapshot's connection state == `done` and snapshot has data
- `isLoading()`: shortcut for snapshot's connection state == `waiting`
- `isComplete()`: 

#### Object scope extensions:
- `let(Function(T))`: invoke lambda passing receiver object
- `asWidgetStateProperty(Map<WidgetState, T>)`: map object as `WidgetStateProperty`

#### `String` extensions:
- `toParagraph()`: map to `dart:ui` `Paragraph`
- `async color()`: compute average color (for emojis) 

#### `TextStyle` extensions:
- `bold()`: copy of this TextStlye with bold font weight

### Helpers

#### `FutureHolder` : 
- Container for `Future`-s with ability to dispose them all on demand.

#### `WidgetBuilderFactory`:
- `buildLoadingState`
- `buildEmptyState`

### Repositories

#### `AssetRepo`:
- `loadJsonList`

#### `ColorRepo`:
- `compute(Characters)`: compute and cache average color of each emoji from given characters
- `get(String)`: get given emoji's color, or null

#### `ThemeRepo`:
- `lightTheme()`: Material 3 light theme data
- `darkTheme()`: Material 3 dark theme data

### Mixins

#### `AnimateOnPressMixin`
 - Set a value (origin 1.0) back and forth from `press()` to `release()` mixin calls. E.g : Create a widget that animates when it is pressed, and animates back once released.

#### `AnimateOnPressHapticMixin`
 - Implementation of `ScaleOnPressMixin` which also triggers haptic feedback.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

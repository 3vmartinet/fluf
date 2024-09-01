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
 - `BuildContext` extensions:
    - `theme` : shortcut for `Theme.of(context)`
    - `textTheme` : shortcut for `Theme.of(context).textTheme`
    - `colorScheme`: shortcut for `Theme.of(context).colorScheme`
- `AsyncSnapshot` extensions:
    - `isReady()`: shortcut for snapshot's connection state == `done` and snapshot has data
    - `isLoading()`: shortcut for snapshot's connection state == `waiting`
    - `isComplete()`: 
- `FutureHolder` : 
    - Container for `Future`-s with ability to dispose them all on demand.
- Repositories:
    - `AssetRepo` :
        - `loadJsonList`


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

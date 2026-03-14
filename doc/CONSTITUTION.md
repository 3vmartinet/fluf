# Project Constitution & Development Guidelines

This document outlines the governing principles, architectural patterns, and coding standards for our Flutter projects. Adherence to these guidelines ensures a highly maintainable, scalable, readable, performant, and consistent codebase.

---

## 1. Architectural Pattern: MVVM (Model-View-ViewModel)

We utilize a strict Model-View-ViewModel architecture to separate business logic from UI rendering.

* **View-Model Binding**: Every distinct screen (and highly complex widget) MUST define and bind to its own View Model (`ChangeNotifier`).
* **State Management (Provider)**: View Models are provided to the widget tree using the `provider` package.
* **UI Consumption**: We strictly prefer utilizing `BuildContext` extension methods (`read`, `watch`, `select`) over highly nested Provider widgets (like `Consumer` or `Selector`). 
    * Use `context.read<MyViewModel>()` for triggering events/callbacks.
    * Use `context.select<MyViewModel, PropertyType>((vm) => vm.property)` to reactively rebuild only when specific properties change.
    * *Rationale*: This keeps the widget tree shallow, concise, and vastly reduces boilerplate verbosity.
* **Complex View States**: When a screen has multiple distinct visual states (e.g., Loading, Success, Error, Empty, Unlocked), these states MUST be modeled using **sealed classes**. The View Model exposes the current sealed state, allowing the UI to use exhaustively matched `switch` statements to render the correct widget.

---

## 2. Business Logic & Dependency Injection

All business logic, external API communication, and data fetching reside in **Repositories**.

### Repository Structure
* **Location & Naming**: All repositories live in the `lib/repo/` directory and MUST end with the suffix `_repo.dart` (e.g., `user_repo.dart`).
* **Sub-grouping**: Repositories that serve similar features or domains should be grouped into subfolders within `lib/repo/` (e.g., `lib/repo/game_services/`).
* **Interfaces for Variants**: If a repository has multiple implementations (e.g., a mock version, a Firebase version, a local storage version), you MUST define an abstract interface class. Both the interface and its implementations must reside in the same subfolder.

### Dependency Injection (`get_it`)
* **Single Registration Point**: All repositories are registered as singletons or lazy singletons in a dedicated `DependenciesRepo` (or `Dependencies` class) at app startup.
* **Interface Resolution**: When an interface exists, the repository MUST be registered under its interface type, not its concrete implementation type.
* **Access Pattern**: Dependencies from `get_it` MUST be accessed using **top-level private getters** within the file they are used, rather than inline calls inside classes or methods.
    * *Example*: `AdRepo get _adRepo => GetIt.I.get<AdRepo>();`

---

## 3. Data & Domain Modeling

* **Location**: All model and data classes reside in the `lib/data/` folder.
* **Sub-grouping**: Similar data classes belonging to the same feature must be grouped into subfolders (e.g., `lib/data/streak/`, `lib/data/division/`).
* **Immutability**: Models must be immutable. Use the `equatable` package for value-based equality. When mutations are necessary, utilize the `copy_with_extension` package to generate `copyWith` methods (`@CopyWith(skipFields: true)`).
* **Enhanced Enums**: Favor Dart's enhanced enums for static data sets, configurations, or bounded logic. Enums should contain their own localized text getters, icons, or specific configuration parameters rather than relying on external switch statements throughout the UI.

---

## 4. UI Architecture & Styling Principles

UI consistency and rendering performance are paramount. 

### Widget Decomposition & Performance
* **Split Complex Screens**: When creating a complex screen, always split it up into smaller, private widgets within the defining file.
* **Const Constructors**: It is crucial for performance to mark as many widgets and classes as `const` as possible. 
* **Context over Injection**: To facilitate the use of `const` constructors, these smaller private widgets MUST consume the data they need directly from the View Model via `BuildContext` extensions (e.g., `context.select`). Avoid injecting View Model data through their constructors, as this prevents the widget from being marked `const`.

### Styling
* **Centralized Theme**: All widget styling (colors, text styles, radiuses, shadows, padding) MUST be defined in a centralized `ThemeRepo` (or global Theme equivalent). 
* **No Inline Styling**: Never style a widget directly in the `build` method using raw `TextStyle` or raw `Color` constructors unless it is a mathematically calculated derivation of the base theme.
* **Animations**: Favor the `flutter_animate` package (`.animate()`) for chained, declarative animations.

---

## 5. General Coding Standards

* **Immutability (`final`)**: Always define variables as `final` if they do not need to be reassigned. Avoid using `var` unless the variable's reference will legitimately change.
* **Constants (`const`)**: There shall never be hard-coded values (magic numbers, raw strings) scattered in the code, and duplication is strictly forbidden. A dedicated `const` variable must always be created. 
    * Constants should be `private` to the file or class by default.
    * They may only be made public if they are legitimately required outside of their defining scope.

---

## 6. The `fluf` & `fluff` Packages Toolkit

You MUST leverage our internal utility packages (`fluf`/`fluff`) to keep the codebase concise. 

### BuildContext Extensions
Instead of calling `Theme.of(context)` or `MediaQuery.of(context)`, use the provided context extensions:
* **Theming**: `context.theme`, `context.textTheme`, `context.colorScheme`.
* **Sizing & Layout**: `context.mediaQuerySize`, `context.breakpoint` (returns enum for compact, medium, expanded, etc.), `context.getRecommendedPadding()`.
* **Navigation**: `context.pushRoute()`, `context.pop()`, `context.slideTo()`, `context.fadeTo()`, `context.revealFrom()`.
* **Localization**: `context.strings` to access generated `AppLocalizations`.
* **Feedback**: `context.snackBar()`.

### Object & Type Extensions
* **Scoping Functions**: Use Kotlin-style scoping functions for cleaner null-checking and chain operations:
    * `myObject?.let((obj) => doSomething(obj))`
    * `myObject.also((obj) => print(obj))`
* **Type Casting**: Use `tryCast<T>()` for safe type casting.
* **Colors**: Use `.plusDelta()` and `.minusDelta()` or `.deltaWithBrightnessOf(context)` for dynamic interactive color states instead of hardcoding multiple shades.
* **Strings**: Use `.captitalize()`, `.toUri()`, `.toClipboardData()`, and `.toParagraph()` where applicable.

---

## 7. Routing & Navigation

* **Enum-Based Routing**: App routes should be strictly defined using an enum (e.g., `AppRoute`). Each enum value represents a distinct path and holds a `build()` method to return the corresponding screen widget.
* **Transitions**: Default to using the custom transition extensions provided by `fluf` (`context.fadeTo`, `context.slideTo`) rather than raw `Navigator.push(MaterialPageRoute(...))` calls.

---

## 8. Error Handling & Logging

* **Centralized Logging**: Never use raw `print()`. Use the `fluff` extension logging methods: `logInfo()`, `logFine()`, `logWarning()`, and `logSevere()`. These wrap standard logging and provide better trace context.
* **Crash Reporting**: Any caught exceptions that represent application failures or unexpected states MUST be forwarded to the `CrashRepo` to be recorded (e.g., Firebase Crashlytics). 

---

## 9. Localization

* **ARB Files**: All strings must be extracted to `.arb` files in the `l10n/` directory. No hardcoded user-facing strings are permitted in the Dart code.
* **Access**: Strings are accessed strictly via `context.strings`.
* **Enum Localization**: Enums that map to UI concepts should accept `AppLocalizations` as a parameter in their descriptor methods (e.g., `myEnum.getDisplayName(context.strings)`).
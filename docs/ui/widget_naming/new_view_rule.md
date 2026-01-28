# Redefined Rule for the `_view` Suffix

This document outlines the new, mandatory convention for using the `_view` widget suffix. This rule supersedes any previous definitions of `_view` as a standalone widget category.

## 1. The `_view` Suffix as a Modifier

The `_view` suffix is no longer an exclusive widget category. Instead, it functions as a **universal modifier** that can be appended to any other widget suffix.

Its sole purpose is to signal that the widget **directly connects to and listens for state changes from the business logic layer**. This typically involves using a `BlocBuilder`, `Consumer`, `Selector`, or a similar state-listening mechanism within the widget's `build` method.

## 2. Compound Naming Convention

This new rule introduces a compound naming system. The primary suffix defines the widget's core purpose, and the `_view` suffix is added if it listens to state.

**Format:** `[prefix]_[name]_[primary_suffix]_view.dart`

### Examples:

-   A `_unit` that displays data passed via its constructor:
    -   `order_card_unit.dart`
-   The same `_unit` modified to also listen to a `Bloc` to update its content:
    -   `order_card_unit_view.dart`

-   An `_action` button that only dispatches an event:
    -   `submit_button_action.dart`
-   The same `_action` button modified to listen to a `Bloc` to show a loading state:
    -   `submit_button_action_view.dart`

## 3. Universal Application (Including `_page`)

This rule applies to **all** widget categories, including `_page`.

### `_page` vs. `_page_view`

The distinction is now based on whether the page widget itself listens to state.

#### `_page` (Standard Page)
A "thin" screen entry point that **does not** listen to state directly in its `build` method. It assumes the required BLoC has been provided by the router or globally.

-   **Responsibilities:** Handles routing, composes layouts and other widgets.
-   **Example File:** `home_page.dart`

```dart
// home_page.dart
// ASSUMPTION: A `HomeBloc` is provided higher up (Router or Global).

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // The page itself does not listen to HomeBloc state.
    // It delegates that responsibility to child widgets.
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: HomeBodyView(), // A child widget listens to the state.
    );
  }
}
```

#### `_page_view` (Stateful Page)
A screen entry point that **does** listen to state directly in its `build` method to control its own rendering. It assumes the required BLoC has been provided by the router or globally.

-   **Responsibilities:** Everything a `_page` does, PLUS conditionally rendering its own content based on BLoC state.
-   **Example File:** `home_page_view.dart`

```dart
// home_page_view.dart
// ASSUMPTION: A `HomeBloc` is provided higher up (Router or Global).

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // The page ITSELF listens to the HomeBloc state.
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError) {
            return const Center(child: Text('An error occurred!'));
          }
          return HomeBody(); // Renders the main content.
        },
      ),
    );
  }
}
```

---

## 4. Rule for `BlocProvider` Location and Scope

To ensure a predictable state lifecycle and keep UI components clean, the location of `BlocProvider` is strictly controlled.

### 4.1 Forbidden: `BlocProvider` in Page Widgets

Using `BlocProvider` or `MultiBlocProvider` directly inside the `build` method of any `_page` or `_page_view` widget is **strictly forbidden**. Page widgets must not be responsible for creating BLoCs.

**WRONG:**
```dart
// ❌ login_page_view.dart
class LoginPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ❌ FORBIDDEN: Provider is inside the page
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        // ...
      ),
    );
  }
}
```

### 4.2 Allowed Patterns

Developers may choose between two patterns for providing BLoCs, depending on the desired lifecycle of the state.

#### Option A: Route-Scoped Providers (Per-Feature)

Providers are wrapped around specific routes within the `GoRouter` configuration.
-   **Lifecycle:** BLoC is created when the route is entered and **disposed** when left.
-   **Use Case:** Feature-specific state that should reset (e.g., Form data, specific article details).

```dart
// ✅ app_router.dart
GoRoute(
  path: '/login',
  builder: (context, state) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginPageView(),
    );
  },
),
```

#### Option B: Global/Shell Providers (App-Wide)

Providers wrap the `MaterialApp` or the top-level `GoRouter` shell.
-   **Lifecycle:** BLoC is created once (or lazily) and **persists** for the entire app session.
-   **Use Case:** App-wide state (e.g., Authentication, User Profile, Theme, Settings).

```dart
// ✅ main.dart or app_router.dart (wrapping the shell)
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => ThemeBloc()),
  ],
  child: MaterialApp.router(...),
)
```

**Key Takeaway:** You must instantiate your BLoCs in the **routing/infrastructure layer**, never in the **presentation layer (pages/views)**.

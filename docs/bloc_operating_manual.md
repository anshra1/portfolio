# Bloc Library: Technical Operating Manual

## 1. Mental Model & Architecture

### The Analogy: The Industrial Assembly Line & Flight Recorder
The Bloc library acts as a **reactive assembly line** coupled with a **flight recorder**. 
*   **The Assembly Line**: Raw materials (**Events**) enter the factory floor. The **Bloc** (processing unit) transforms these materials through a serialized event loop. The finished products (**States**) are shipped to the loading dock (**UI**). 
*   **The Flight Recorder**: Because state transitions are discrete and gated by events, the system provides a verifiable log of every interaction. This makes the application history fully traceable and reproducible.

### Layered Architecture
The system is strictly divided into three layers:
1.  **Data Layer**: 
    *   **Data Provider**: Raw data access (API, DB).
    *   **Repository**: Abstraction layer that composes providers and exposes domain models. **Crucial**: Repositories never know about Blocs.
2.  **Business Logic Layer (Bloc)**:
    *   Bridges the Data Layer and Presentation Layer.
    *   Responds to **Events** from the UI.
    *   Reads from **Repositories**.
    *   Emits **States**.
3.  **Presentation Layer (UI)**:
    *   Renders based on **State**.
    *   Sends **Events** based on user interaction.
    *   **Crucial**: UI logic (formatting dates, colors) stays here; Business logic (validation, calculation) stays in Bloc.

### Data Flow
*   **Unidirectional**: UI $\rightarrow$ Event $\rightarrow$ Bloc $\rightarrow$ State $\rightarrow$ UI.
*   **Gated Transitions**: State cannot change spontaneously. It must be a response to an incoming Event processed by the Bloc's internal logic.
*   **Asynchronous Serialization**: All state transitions happen on the next tick of the event loop.

### State Management
*   **Ownership**: The Bloc instance owns the state absolutely.
*   **Immutability**: States are immutable. Updates involve emitting a new instance rather than modifying an existing one.

---

## 2. The "Golden Path" Implementation (Bloc)

Use `Bloc` when you need event traceability or advanced event transformation (debounce, throttle).

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. DEFINITIONS: Use 'sealed' for exhaustive UI state checks
sealed class CounterEvent {}
final class CounterIncrementPressed extends CounterEvent {}

final class CounterState {
  final int value;
  const CounterState(this.value); // Immutable contract
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    // 2. LOGIC: Logic lives here. emit() is ONLY allowed inside handlers.
    on<CounterIncrementPressed>((event, emit) {
      emit(CounterState(state.value + 1));
    });
  }
}

// 3. INJECTION: Scoped to the necessary subtree
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(), // Provider owns and closes the Bloc
      child: const CounterView(),
    );
  }
}

// 4. CONSUMPTION: Granular UI updates and side-effects
class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterBloc, CounterState>(
        // Rebuild only when necessary (Optimization)
        buildWhen: (prev, curr) => prev.value != curr.value,
        builder: (context, state) {
          return Center(child: Text('${state.value}'));
        },
        // Side-effects (Navigation, Snackbars) MUST go here
        listenWhen: (prev, curr) => curr.value == 10,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Goal Reached!')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Use context.read for event triggering (safe inside callbacks)
        onPressed: () => context.read<CounterBloc>().add(CounterIncrementPressed()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Multi-Provider Pattern
To avoid nesting hell, use `MultiBlocProvider` when injecting multiple Blocs.

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => BlocA()),
    BlocProvider(create: (context) => BlocB()),
  ],
  child: App(),
)
```

---

## 3. The Simpler Path: Cubit

Use `Cubit` for simple state management where event tracking is unnecessary. It exposes functions instead of processing events.

```dart
// 1. DEFINITION
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // 2. LOGIC: Direct function calls
  void increment() => emit(state + 1);
}

// 3. CONSUMPTION
// Triggering changes (in UI):
context.read<CounterCubit>().increment();
```

**Rule**: Start with Cubit. Refactor to Bloc only when you need the "Flight Recorder" (traceability) or "Assembly Line Control" (transformers).

---

## 4. Naming Conventions (Strict)

Adhere to these rules to maintain codebase consistency.

### Events (Bloc Only)
*   **Tense**: Must be **Past Tense**. They represent things that *happened*.
*   **Syntax**: `[Subject] + [Action (Verb)] + [Context/Suffix (Optional)]`
*   **Examples**:
    *   ✅ `CounterIncrementPressed` (User pressed it)
    *   ✅ `OrderSubmitted` (System event)
    *   ❌ `IncrementCounter` (Command/Imperative)
    *   ❌ `SubmitOrder`

### States
*   **Part of Speech**: Must be **Nouns**. They represent a *snapshot*.
*   **Syntax**: `[Subject] + [Status/Description]`
*   **Examples**:
    *   ✅ `CounterLoadSuccess`
    *   ✅ `AuthFailure`
    *   ❌ `Loaded` (Ambiguous)
    *   ❌ `Loading` (Adjective/Verb)

---

## 5. Advanced: Event Transformers

When you need to control *how* events are processed (e.g., ignore rapid clicks, process sequentially), use transformers.
*   **Concurrent** (Default): Process all events as they come.
*   **Sequential**: Process one after another (good for transactional logic).
*   **Droppable**: Ignore new events if one is currently processing.
*   **Restartable**: Cancel current processing and start new event (good for search).

```dart
import 'package:bloc_concurrency/bloc_concurrency.dart';

on<SearchTextChanged>(
  (event, emit) async { ... },
  transformer: restartable(), // Cancels previous search if typing continues
);
```

---

## 6. Critical Rules (The "Musts")

*   **Bloc-to-Bloc Communication**:
    *   **Forbidden**: Blocs listening to other Blocs' streams directly.
    *   **Allowed**:
        1.  **Repository Sync**: Both Blocs listen to the same Repository stream.
        2.  **UI Orchestration**: The UI listens to Bloc A and adds an event to Bloc B.
*   **Single-Path Mutation**: Enforce exactly one way to change a specific state. No back-door methods or public setters.
*   **Lifecycle Ownership**: 
    *   `BlocProvider(create: ...)` = Provider closes the Bloc.
    *   `BlocProvider.value(value: ...)` = You must close the Bloc manually.
*   **Pure Builders**: The `builder` function in `BlocBuilder` must be side-effect free. It will be called multiple times by the Flutter framework.
*   **Separation of Concerns**: If a code block decides *what* the next state should be, it must live in the Bloc. If it decides *how* to display state, it lives in the Widget.

---

## 7. Foot-Guns & Anti-Patterns

*   **The "Same Context" Trap**:
    *   *Anti-Pattern*: Trying to `context.read<MyBloc>()` in the *same* widget that created the `BlocProvider`.
    *   *Why*: The `BuildContext` passed to `build` is the parent of the `BlocProvider`, so it can't see the provider.
    *   *Fix*: Wrap the child in a `Builder` or extract it to a separate widget class.
*   **Broken Equatable**:
    *   *Anti-Pattern*: Forgetting to include a property in `props` or modifying a List/Map in place.
    *   *Result*: `stateA == stateB` returns true, so the UI never updates.
    *   *Fix*: Always return `List.of(oldList)` or `Map.of(oldMap)` to ensure new references, and verify all fields are in `props`.
*   **`context.read` in Build**:
    *   *Anti-Pattern*: `Text(context.read<MyBloc>().state.value.toString())`
    *   *Result*: The widget will not rebuild when the state changes.
    *   *Fix*: Use `BlocBuilder` or `context.watch`.
*   **In-Place Mutation**:
    *   *Anti-Pattern*: `state.list.add(item); emit(state);`
    *   *Result*: Bloc compares objects by reference. Since the reference is the same, no update is triggered.
    *   *Fix*: `emit(state.copyWith(list: List.from(state.list)..add(item)));`
*   **Navigation in Builder**:
    *   *Anti-Pattern*: Calling `Navigator.push` inside a `builder` method.
    *   *Result*: Multiple screens pushed if the builder fires multiple times (e.g., during a screen resize).
    *   *Fix*: Use `BlocListener`.
*   **Global Singletons**: Storing Blocs in global variables. This breaks widget-tree scoping and causes memory leaks by preventing proper disposal.

---

## 8. Testing Strategy

Testing is not optional. It is the "Flight Recorder" verification.

### Dependencies
Use the `bloc_test` package.

### Anatomy of a Test
Use the `blocTest` helper for declarative testing of event-to-state transitions.

```dart
import 'package:bloc_test/bloc_test.dart';

blocTest<CounterBloc, CounterState>(
  'emits [1] when CounterIncrementPressed is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(CounterIncrementPressed()),
  expect: () => [
    const CounterState(1),
  ],
);
```

### Key Rules
*   **Test Outputs, Not Internals**: Verify that *Input A* leads to *Output B*. Do not test private functions.
*   **Mock Repositories**: Always mock the Data Layer (Repositories) to isolate the Business Logic.
*   **Seed States**: Use `seed` in `blocTest` to start the Bloc in a specific state for intermediate tests.

---

## 9. Type & API Contract

### Context Extension Matrix
| Method | Target | Rebuilds Widget? | Recommended Location |
| :--- | :--- | :--- | :--- |
| `context.read<T>()` | Bloc Instance | **No** | Callbacks (onPressed) |
| `context.watch<T>()` | Full State | **Yes** | `build` method (Small widgets) |
| `context.select<T, R>()` | Part of State | **Yes** (Only on R change) | `build` method (Optimization) |

### Error Handling
*   Blocs catch unhandled exceptions in `onError`.
*   To notify the UI, model errors as part of the state (e.g., `State.error`) or emit a specific `ErrorState`.

---

## 10. Implicit Assumptions & Documentation Gaps

*   **Equality Implementation**: The entire library's efficiency (and correctness) assumes State and Event objects implement value equality. Using the `equatable` package is effectively mandatory unless using Data Classes (Dart 3).
*   **Streams**: The library assumes familiarity with Dart Streams (`yield`, `await for`, `StreamSubscription`).

# Bloc Library: Technical Operating Manual

## Part 1: Philosophy & Mental Model

### The Analogy: The Industrial Assembly Line
The Bloc library acts as a **reactive assembly line** coupled with a **flight recorder**.
*   **The Assembly Line**: Raw materials (**Events**) enter the factory floor. The **Bloc** (processing unit) transforms these materials through a serialized event loop. The finished products (**States**) are shipped to the loading dock (**UI**).
*   **Layered Architecture**:
    1.  **Data Layer** (Repositories): Abstraction over API/DB. *Never knows about Blocs.*
    2.  **Business Logic Layer** (Bloc): Bridges Data and UI. Receives Events, emits States.
    3.  **Presentation Layer** (UI): Renders State, sends Events.

### Data Flow
*   **Unidirectional**: UI $\rightarrow$ Event $\rightarrow$ Bloc $\rightarrow$ State $\rightarrow$ UI.
*   **Ownership**: The Bloc instance owns the state absolutely.
*   **Immutability**: States are immutable. Updates involve emitting a new instance.

---

## Part 2: Authoring Standards (Defining Logic)

### 1. Naming Conventions (Usage-Based)
Adhere to these rules to maintain codebase consistency.

#### Events: UI $\rightarrow$ Bloc (The "What Happened" Layer)
*   **Tense**: Must be **Past Tense**.
*   **Suffix**: Must strictly end with `Event`.
*   **Syntax**: `[Subject] + [Action (Verb)] + [Context] + Event`
*   **Examples**:
    *   ✅ `CounterIncrementPressedEvent` (User pressed it)
    *   ✅ `OrderSubmittedEvent` (System event)
    *   ❌ `IncrementCounter` (Missing suffix/Imperative)

#### States: Bloc $\rightarrow$ UI (The "Snapshot" Layer)
*   **Structure**: Use a **Sealed Class Hierarchy** (Separate classes).
*   **Suffix**: Must strictly end with `State`.
*   **Syntax**: `[Subject] + [Status] + State`
*   **Examples**:
    *   ✅ `CounterLoadSuccessState`
    *   ✅ `AuthFailureState`
    *   ❌ `CounterLoaded` (Missing suffix)

### 2. The Golden Path: Bloc
Use `Bloc` when you need event traceability or advanced event transformation (debounce, throttle).

```dart
// Event
sealed class CounterEvent {}
final class CounterIncrementPressedEvent extends CounterEvent {}

// State (Sealed Hierarchy)
sealed class CounterState {
  const CounterState();
}
final class CounterInitialState extends CounterState {}
final class CounterSuccessState extends CounterState {
  final int value;
  const CounterSuccessState(this.value);
}

// Logic
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on<CounterIncrementPressedEvent>((event, emit) {
      final currentValue = state is CounterSuccessState 
          ? (state as CounterSuccessState).value 
          : 0;
      emit(CounterSuccessState(currentValue + 1));
    });
  }
}
```

### 3. The Simpler Path: Cubit
Use `Cubit` for simple state management where event tracking is unnecessary.

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}
```

---

## Part 3: Dependency Management (Wiring)

### 1. The Provider Pattern
Use `BlocProvider` to create and close Blocs. It manages the lifecycle of the business logic.

### 2. Multi-Provider
Use `MultiBlocProvider` to avoid the "Pyramid of Doom" when providing multiple dependencies.

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

## Part 4: UI Interaction (Consumption Layer)

### 1. Rebuild Extensions: read, watch, select
These extensions are the primary way to interact with Blocs from the UI.

| Method | Usage | Rebuilds Widget? | Recommended Location |
| :--- | :--- | :--- | :--- |
| `context.read<T>()` | To add events/call methods | **No** | Callbacks (`onPressed`) |
| `context.watch<T>()` | To listen to full state | **Yes** | `build` method (Small widgets) |
| `context.select<T, R>()` | To listen to part of state | **Yes** (Only on change) | `build` method (Optimization) |

### 2. Optimized Selection: `BlocSelector`
**Best Practice**: Use this to stop rebuilding the entire widget when only one field changes. It acts like a filter/mapper.
```dart
// Only rebuilds if 'value' changes in SuccessState.
BlocSelector<CounterBloc, CounterState, int>(
  selector: (state) => state is CounterSuccessState ? state.value : 0,
  builder: (context, value) {
    return Text('Count: $value');
  },
);
```

### 3. Navigation: `BlocProvider.value`
To share an *existing* instance with a new route:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: context.read<CounterBloc>(),
      child: const NextScreen(),
    ),
  ),
);
```

---

## Part 5: Advanced Engineering (Guardrails)

### 1. Reactivity: `emit.forEach`
Bridge Data Layer Streams to the Bloc safely. Handles subscription/unsubscription automatically.

```dart
on<SubscriptionRequested>((event, emit) async {
  await emit.forEach<int>(
    repository.intStream(),
    onData: (value) => state.copyWith(value: value),
  );
});
```

### 2. Concurrency: Transformers
Control how events are processed (e.g., `restartable()`, `droppable()`).

```dart
import 'package:bloc_concurrency/bloc_concurrency;

on<SearchTextChanged>(
  (event, emit) async { ... },
  transformer: restartable(), // Cancels previous search if typing continues
);
```

### 3. Safety: Exhaustive Switching
Use Dart 3 `sealed` classes to ensure the UI handles every possible state.

```dart
return switch (state) {
  AuthInitial() => const LoginScreen(),
  AuthLoading() => const LoadingSpinner(),
  AuthAuthenticated(user: var u) => HomeScreen(user: u),
  AuthFailure(error: var e) => ErrorScreen(message: e),
};
```

### 4. Critical Rules (The "Musts")
*   **Bloc-to-Bloc Communication**:
    *   **Forbidden**: Blocs listening to other Blocs' streams directly.
    *   **Allowed**: UI Orchestration (UI listens to A, adds event to B) or Repo Sync (Both listen to Repo).
*   **Single-Path Mutation**: Enforce exactly one way to change a specific state. No back-door methods or public setters.

### 5. Anti-Patterns (The "Foot-Guns")
*   **The "Same Context" Trap**:
    *   *Anti-Pattern*: Trying to `context.read<MyBloc>()` in the *same* widget that created the `BlocProvider`.
    *   *Fix*: Wrap the child in a `Builder` or extract it to a separate widget class.
*   **Broken Equatable**:
    *   *Anti-Pattern*: Forgetting to include a property in `props` or modifying a List/Map in place.
    *   *Result*: `stateA == stateB` returns true, so the UI never updates.
*   **In-Place Mutation**:
    *   *Anti-Pattern*: `state.list.add(item); emit(state);`
    *   *Result*: Bloc compares objects by reference (same instance), so no update triggers.
    *   *Fix*: `emit(state.copyWith(list: List.of(state.list)..add(item)));`

---

## Part 6: Observability: The BlocObserver flight recorder

### 1. Global Monitoring: `BlocObserver`
The "Flight Recorder" that logs every transition and error in the system.

```dart
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }
}
```

### 2. Verification: Testing Strategy
Use `bloc_test` for declarative `build` -> `act` -> `expect` verification.

```dart
blocTest<CounterBloc, CounterState>(
  'emits [1] when CounterIncrementPressedEvent is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(CounterIncrementPressedEvent()),
  expect: () => [const CounterSuccessState(1)],
);
```
*   **Rule**: Test outputs (States), not internals.
*   **Rule**: Mock all Repositories.

```

# Bloc Library: Technical Operating Manual

## Part 1: Philosophy & Mental Model

### The Analogy: The Industrial Assembly Line
The Bloc library acts as a **reactive assembly line**.
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
*   **Tense**: Must be **Past Tense**. They represent things that *happened*.
*   **Syntax**: `[Subject] + [Action (Verb)] + [Context/Suffix]`
*   **Examples**:
    *   ✅ `CounterIncrementPressed` (User pressed it)
    *   ✅ `OrderSubmitted` (System event)
    *   ❌ `IncrementCounter` (Command/Imperative)

#### States: Bloc $\rightarrow$ UI (The "Snapshot" Layer)
*   **Part of Speech**: Must be **Nouns**. They represent a *snapshot* of the system.
*   **Syntax**: `[Subject] + [Status/Description]`
*   **Examples**:
    *   ✅ `CounterLoadSuccess`
    *   ✅ `AuthFailure`
    *   ❌ `Loading` (Adjective/Verb)

### 2. The Golden Path: Bloc
Use `Bloc` when you need event traceability or advanced event transformation (debounce, throttle).

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<CounterIncrementPressed>((event, emit) {
      emit(CounterState(state.value + 1));
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

### 2. Optimization: `BlocSelector`
Stop rebuilding the entire widget when only one field changes.

```dart
BlocSelector<UserBloc, UserState, String>(
  selector: (state) => state.name,
  builder: (context, name) {
    return Text('Hello $name');
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

### 3. Safety: Exhaustive Switching
Use Dart 3 `sealed` classes to ensure the UI handles every possible state.

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
}
```

### 2. Verification: Testing Strategy
Use `bloc_test` for declarative `build` -> `act` -> `expect` verification.

```
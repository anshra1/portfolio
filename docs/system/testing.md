# Testing: Flutter Quality Standards

This document defines the protocols for writing and executing tests. **AI agents MUST read this file** before performing the `/test` or `/debug` commands to ensure alignment with the project's TDD philosophy.

---

## 1. Core Principles

*   **TDD First**: Tests must be written and verified as "failed" before implementation logic is added.
*   **Isolated Testing**: Use mocks to isolate the unit under test. **Never** hit real APIs or databases in Unit/Widget tests.
*   **Explicit Success**: Every test must have a clear "Given-When-Then" structure.

---

## 2. Test Categorization

### **Unit Tests (Domain & Data Layer)**
*   **Target**: Use Cases, Repositories (Implementation), and Models.
*   **Requirement**: Use Cases must have 100% path coverage (Happy path + all Failure cases).
*   **Tooling**: Use `dart:test` and `mocktail`.

### **BLoC Tests (Presentation Layer)**
*   **Target**: BLoC state transitions.
*   **Requirement**: Every test must verify the exact sequence of states.
*   **Pattern**: Use `blocTest` from the `bloc_test` package.
*   **Mandatory Flow**: Verify that `[State]Loading` is emitted before `[State]Loaded` or `[State]Error`.

### **Widget Tests**
*   **Target**: Reusable UI components and Pages.
*   **Focus**: Verify that the UI reacts correctly to different BLoC states (e.g., shows a `CircularProgressIndicator` during the loading state).

---

## 3. Naming Conventions

*   Test descriptions must follow the "`should [action] when [condition]`" pattern.
    *   **Correct**: `should emit [Loaded] when [FetchData] is successful`
    *   **Incorrect**: `test fetching data`

---

## 4. Mocking Strategy (Mocktail)

*   **Setup**: Create Mocks for all dependencies (Repositories for Use Cases, Use Cases for BLoCs).
*   **Stubbing**: Use `when(() => ...).thenAnswer(...)` for asynchronous calls and `thenReturn` for synchronous ones.
*   **Verification**: Always verify that the dependency was called the expected number of times using `verify(() => ...).called(1)`.

---

## 5. Standard Test Template (AI Reference)

When generating a BLoC test, use this structure:

```dart
blocTest<MyBloc, MyState>(
  'should emit [Loading, Loaded] when GetData is successful',
  build: () {
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => Right(tData));
    return myBloc;
  },
  act: (bloc) => bloc.add(GetDataEvent()),
  expect: () => [
    isA<MyState>().having((s) => s.status, 'status', MyStatus.loading),
    isA<MyState>().having((s) => s.status, 'status', MyStatus.loaded),
  ],
  verify: (_) {
    verify(() => mockUseCase.call(any())).called(1);
  },
);
```

---

## 6. Execution Workflow

1.  **AI**: Writes tests based on requirements in `system_patterns.md`.
2.  **User**: Runs `flutter test`.
3.  **Observation**: Confirm the test fails with a "Method not implemented" or similar error.
4.  **AI**: Implements the feature logic until the test passes.

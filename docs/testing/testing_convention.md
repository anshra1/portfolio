# Conventions: Flutter Testing & Quality Assurance

This document defines the strict standards for writing tests within the project. AI agents and Developers MUST apply these rules to ensure high coverage, maintainability, and deterministic execution.

---

## 1. Core Philosophy

### The AAA Pattern
Every test case MUST be visually separated into three distinct stages using comments.
*   **Arrange**: Setup conditions and mocks.
*   **Act**: Execute the function or trigger the event.
*   **Assert**: Verify the result and side effects.

### Equality & Value Objects
To ensure assertions like `expect(result, Right(tEntity))` work correctly, all **Entities** and **Models** MUST extend `Equatable`. Avoid manual property-by-property comparison in tests.

---

## 2. Test Directory Structure

The `test/` directory MUST mirror the `lib/` directory structure 1-to-1.

```text
test/
├── fixtures/              # JSON files for API responses
├── helpers/               # Shared utilities (pump_app.dart, fixture_reader.dart)
├── goldens/               # Reference images for visual regression
├── features/
│   └── [feature_name]/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── core/                  # Core utility tests
└── integration_test/      # End-to-end smoke tests
```

---

## 3. Naming Conventions & Syntax

### Files
*   **Suffix**: All test files MUST end in `_test.dart`.
*   **Mirroring**: `lib/.../user_model.dart` -> `test/.../user_model_test.dart`.

### Test Descriptions
Tests MUST be readable as English sentences using the "should [result] when [condition]" pattern.
*   **Group**: Use the Class Name or Method Name.
*   **Test**: `test('should emit [Authenticated] when login is successful', ...)`

### Variables
*   **SUT**: System Under Test (the instance being tested).
*   **Constants**: Prefix with `t` (e.g., `tUser`, `tEmail`).
*   **Mocks**: Prefix with `mock` (e.g., `mockAuthRepo`).

---

## 4. Layer-Specific Strategies

### A. Data Layer: Models
*   **Objective**: Ensure JSON serialization/deserialization.
*   **Checklist**:
    *   Verify `fromJson` returns a valid model.
    *   Verify `toJson` returns the expected Map.
    *   Load JSON from `test/fixtures/` using a helper.

### B. Data Layer: Repositories
*   **Objective**: Test implementation logic and exception mapping.
*   **Scenarios**: 
    *   Success (Right).
    *   Failures (Left with Server/Cache/Network Failures).

### C. Domain Layer: UseCases
*   **Strictness**: Logic-only; 100% code coverage required.
*   **Logic**: Simply verify the Usecase calls the correct repository method.

### D. Presentation Layer: BLoC
*   **Library**: `bloc_test` is MANDATORY.
*   **Expectations**: List ALL states emitted in order. Do not skip states.

### E. Presentation Layer: Widgets & Goldens
*   **Finders**: Prefer `find.byKey()` for stability.
*   **Golden Tests**: Use Golden tests for complex UI components to prevent visual regression. 
*   **Pumping**: Use `pump()` for state changes; `pumpAndSettle()` for animations.

---

## 5. Mocking, Fakes & Fixtures

### Mocktail
*   Preferred library: `mocktail`.
*   **Setup**: Register fallback values in `setUpAll` for custom objects.

### Fakes vs. Mocks
*   Use **Mocks** for verifying interactions (e.g., "was this method called?").
*   Use **Fakes** for complex behavior (e.g., a `FakeAuthService` that maintains an internal login state) to keep tests readable.

### Fixtures
*   NEVER hardcode large JSON strings. 
*   Use a `fixture_reader.dart` utility to load files from `test/fixtures/`.

---

## 6. Integration Testing (Smoke Tests)
*   Critical paths (Login, Checkout, Onboarding) MUST have at least one integration test using the `integration_test` package to verify the app works as a whole on a real device/emulator.

---

## 7. Quality Gates & Forbidden Actions

### Forbidden
*   **NO Real Network Calls**: All external dependencies must be mocked/faked.
*   **NO print Statements**: Use standard logging or debuggers.
*   **NO sleep/Future.delayed**: Use `pump` or `stream` expectations.
*   **NO Logic in main**: Use `setUp` and `tearDown`.

### Quality Gates (CI/CD)
*   **Coverage**: PRs should not decrease the project's overall code coverage.
*   **Static Analysis**: `flutter analyze` must pass before running tests.
*   **Testing**: `flutter test` must pass 100% on the CI pipeline.

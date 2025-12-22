# System Patterns: Flutter Clean Architecture & BLoC

This document defines the architectural DNA of the project. **AI agents MUST adhere to these patterns** to maintain consistency and prevent technical debt.

---

## 1. Core Architecture (Layered Clean Architecture)
The system is divided into three strict layers. Dependencies **only point inwards**.

### **Data Layer (Outer)**
*Handles data retrieval and transformation.*
*   **Repositories Implementation**: Implements domain interfaces. Decides between remote vs. local sources.
*   **Data Sources**: Low-level calls (e.g., Dio for network, SharedPreferences/Isar for local).
*   **Models**: Data Transfer Objects (DTOs) with `fromJson`/`toJson`.
    *   *Rule*: Models **MUST** extend Domain Entities and use a `.toEntity()` mapper.

### **Domain Layer (Center - Pure Dart)**
*Contains business logic. No Flutter dependencies.*
*   **Entities**: Simple POJOs (Plain Old Dart Objects).
*   **Repositories Interfaces**: Abstract classes defining contracts for data operations.
*   **Use Cases**: Single-responsibility classes (e.g., `GetProductDetails`).
    *   *Rule*: Use the `call()` method pattern for execution.

### **Presentation Layer (Outer)**
*Handles UI and State Management.*
*   **BLoCs**: Manage state transitions.
    *   *Rule*: **No business logic**. BLoCs only call Use Cases.
*   **Pages**: Top-level widgets linked to a BLoC.
*   **Widgets**: Reusable UI components.

---

## 2. BLoC Pattern Standards
We follow a strict **Event-State** flow to prevent UI bloat.

*   **State Composition**: Every BLoC state **MUST** be a single class using `freezed` (preferred) or `Equatable`.
    *   *Standard Sub-states*: `initial`, `loading`, `loaded`, `error`.
*   **Event Naming**: `[Feature][Subject][Verb]`
    *   *Examples*: `AuthLoginStarted`, `CartItemRemoved`.
*   **Logic Placement**:
    *   BLoCs must **only** call Use Cases.
    *   **NEVER** perform direct repository calls or complex business logic inside the BLoC.

---

## 3. Functional Error Handling
We avoid `try-catch` blocks in higher layers. Failures must be explicit.

*   **Return Type**: All Repository and Use Case methods return `Future<Either<Failure, T>>`.
*   **Left (Failure)**: Use a standard `Failure` class hierarchy (e.g., `ServerFailure`, `CacheFailure`).
*   **Right (Success)**: The actual data result.
*   **Handling**: Use the `.fold()` method in the BLoC to map `Failure` to a UI error message.

---

## 4. Dependency Injection (DI)
*   **Service Locator**: Use `GetIt`.
*   **Registration File**: `lib/core/di/injection_container.dart`.

### **Lifecycle Rules**
*   **`registerFactory`**: For **BLoCs** (creates a new instance per use).
*   **`registerLazySingleton`**: For **Use Cases**, **Repositories**, and **Data Sources**.

---

## 5. UI & Naming Conventions

### **Folder Structure**
Follow a feature-first structure:
`lib/features/[feature_name]/[layer]`

### **Widget Consistency**
*   **Complex UI**: Use `_build[ElementName]` methods to keep the main `build` method clean.
*   **Strings**: **No hardcoded strings**. Use the `S.of(context)` (Intl) pattern.
*   **Colors**: **No hardcoded colors**. Use `Theme.of(context).colorScheme`.
*   **Async UI**: Use `BlocConsumer` or `BlocBuilder`.
    *   *Rule*: Always handle the `loading` state with a specific UI indicator.

---

## 6. Testing Philosophy
AI **MUST** follow these rules when generating tests:

*   **Unit Tests**: **Mandatory** for Use Cases and BLoCs. Use the `bloc_test` package.
*   **Mocks**: Use `mocktail` for mocking dependencies.
*   **Contract**: Every BLoC test must verify that `loading` is emitted **before** `loaded` or `error`.

---

## 7. Gold Standard Example
For the perfect implementation of a functional use case, refer to:
`lib/features/auth/domain/usecases/login_user.dart`

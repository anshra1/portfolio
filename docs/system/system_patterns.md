# System Patterns: Flutter Clean Architecture & BLoC

This document defines the architectural DNA of the project. **AI agents MUST adhere to these patterns** to maintain consistency and prevent technical debt.

---

## 1. Core Architecture & Standards

### **Architectural Style**
*   **Pattern:** Strict Clean Architecture (Presentation → Domain → Data).
*   **Dependency Rule:** Dependencies **only point inwards**. Upward dependencies are forbidden (e.g., Domain cannot import Presentation).
*   **Structure:** Feature-first folder structure (`lib/features/[feature_name]/[layer]`).
*   **State Management:** `flutter_bloc`.
*   **Import Style:** Absolute Package Imports (e.g., `import 'package:[app_name]/features/...'`).

### **Decision Framework: "Who says 'No'?"**
To decide where logic belongs, ask: **"Who has the authority to stop this action?"**
*   **OS / Device says 'No'** → **UI / Presentation** (e.g., "Screen too small", "Double tap ignored").
*   **Infrastructure says 'No'** → **Data Layer** (e.g., "No internet", "Disk full", "Server 500").
*   **Product Rules say 'No'** → **Domain Layer** (e.g., "User not admin", "Balance insufficient", "Limit reached").

### **Core Libraries & Paths**
*   **Result Types:** `ResultFuture<T>` / `ResultStream<T>` defined in `lib/core/common/typedefs.dart`.
*   **Error Handling:** Base `Failure` class defined in `lib/core/error/failures.dart`.
*   **Functional Ops:** `dartz` package (for `Either`).
*   **Testing:** `flutter_test` and `mocktail` (Manual mocking, no code gen).

---

## 2. Domain Layer (Center - Pure Dart)

*The guardian of product correctness. Logic here is unconditional and technology-agnostic.*

### **2.1 Domain Entities**
*   **Definition:** Simple POJOs (Plain Old Dart Objects).
*   **Rules:**
    *   Pure Dart classes (No Flutter imports).
    *   Immutable by default.
    *   No JSON / serialization logic.
    *   No annotations.

### **2.2 Repositories Interfaces (Contracts)**
*   **Definition:** Abstract classes defining contracts for data operations.
*   **Rules:**
    *   Contains **no implementation**.
    *   Returns domain entities only.
    *   Uses `ResultFuture` types for success/failure.

### **2.3 Use Cases**
*   **Definition:** Single-responsibility classes (e.g., `GetProductDetails`).
*   **Structure:**
    *   **Grouping Rule:** All use cases for a specific feature **MUST** be grouped into a single file named `[feature]_usecase.dart` (e.g., `lib/features/projects/domain/usecases/project_usecase.dart`).
    *   Wraps exactly **one** repository method.
    *   Extends exactly **one** base class: `FutureUseCaseWithParams`, `FutureUseCaseWithoutParams`, `StreamUseCaseWithParams`, or `StreamUseCaseWithoutParams`.
*   **Rules:**
    *   Use the `call()` method pattern for execution.
    *   No business logic outside the repository.
    *   No branching except parameter validation.
    *   Must return `ResultFuture<T>` or `ResultStream<T>`.

### **2.4 Domain Logic Rules (The "9 Rule Types")**
Logic here must fall into one of these categories:
1.  **Validity:** "Task title cannot be empty."
2.  **Permission:** "Only owner can delete."
3.  **Quantity/Limits:** "Free tier max 5 projects."
4.  **State Transitions:** "Cannot move from 'Delivered' to 'Shipped'."
5.  **Field Dependencies:** "Urgent tasks must have a due date."
6.  **Monetary/Pricing:** "Refunds only within 30 days."
7.  **Time-based:** "Login bonus once per day."
8.  **Data Invariants:** "Email must be unique."
9.  **Workflow Sequence:** "Payment must complete before Order Confirmation."

---

## 3. Data Layer (Outer)

*Handles execution and orchestration of data retrieval.*

### 3.1 Models
*   **Definition:** Data Transfer Objects (DTOs) generated using the `freezed` package.
*   **Rules:**
    *   Must use `@freezed` annotation for immutability and `copyWith`.
    *   Must use `@JsonSerializable` (via `freezed`) for `fromJson`/`toJson`.
    *   **Mapping:** Must implement a `toEntity()` method to convert the freezed model to the pure Domain Entity.

### 3.2 Data Sources (The "Dumb Executor")
*   **Definition:** Low-level calls (e.g., Dio for network, SharedPreferences/Isar for local).
*   **Rules:**
    *   **Raw I/O only:** HTTP GET, Database Query, File Read.
    *   **Serialization:** JSON ↔ DTO.
    *   **No Decisions:** No branching or business rules.
    *   **Errors:** Throw `AppException`, never return `Result`.

### 3.3 Repositories Implementation (The "Decision Maker")
*   **Definition:** Implements domain interfaces. Decides between remote vs. local sources.
*   **Smart Repo Protocol (Logic Categories):**
    A repository may contain logic **only** if it falls into one of these categories:
    1.  **Routing**: Source selection (Remote vs Local).
    2.  **Policy decisions**: Business rules application.
    3.  **Error mapping**: Catch **Exceptions** (e.g., `ServerException`) and map to **Failures** (e.g., `ServerFailure`).
    4.  **Aggregation**: Combining multiple sources.
    5.  **Transformation**: In-memory processing.
    6.  **Cross-Cutting**: Trigger Analytics and Crash Reporting.
    *   *If none apply, the repository must be pure delegation.*
*   **Safety:** All external calls must be wrapped in `try-catch` blocks.
*   **Mapping:** Data `Model` → `Entity` (using `.toEntity()`).

---

## 4. Presentation Layer (The "UI")

*Visualizing state and capturing user intent.*

### **4.1 State Management (Bloc/Cubit)**
*   **Responsibilities:**
    *   **Screen States:** Loading, Success, Error, Empty, Idle.
    *   **UX Guard Logic:** Ignoring double taps, debouncing search, disabling buttons while saving.
    *   **UI Transformation:** Mapping `Domain User` → `UserUiModel` (e.g., formatting dates).
    *   **Filtering/Sorting:** "Show only completed tasks" (Visual preference, not business rule).

### **4.2 UI Widgets (The "Renderer")**
*   **Responsibilities:**
    *   **Pure Rendering:** `if (state is Loading) return Spinner();`
    *   **Trivial Formatting:** Colors, Icons, Padding.
    *   **Wiring Actions:** `onTap: () => cubit.submit()`

---

## 5. Functional Error Handling

We avoid `try-catch` blocks in higher layers. Failures must be explicit.

*   **Return Type:** All Repository and Use Case methods return `Future<Either<Failure, T>>`.
*   **Left (Failure):** Use a standard `Failure` class hierarchy (e.g., `ServerFailure`, `CacheFailure`).
*   **Right (Success):** The actual data result.
*   **Handling:** Use the `.fold()` method in the BLoC to map `Failure` to a UI error message.
*   **Type Safety:** Strictly return `Either<Failure, T>`, never raw objects or exceptions.

---

## 6. Dependency Injection (DI)

*   **Service Locator:** Use `GetIt`.
*   **Registration File:** `lib/core/di/injection_container.dart` (or `lib/core/di/injection.dart`).
*   **Style:** Manual `get_it` registration (`sl.registerLazySingleton`). Do **not** use `@injectable` annotations.

### **Lifecycle Rules**
*   **`registerFactory`**: For **BLoCs** (creates a new instance per use).
*   **`registerLazySingleton`**: For **Use Cases**, **Repositories**, and **Data Sources**.

---

## 7. Naming Conventions

*   **Use cases:** `VerbNoun` (e.g. `GetUserProfile`).
*   **Repositories:** `FeatureRepository`.
*   **Data sources:** `RemoteFeatureDataSource`, `LocalFeatureDataSource`.

---

## 8. Definition of Done

*   **Completeness:** No `UnimplementedError`. All interface methods must be overridden.
*   **Purity:** No UI code (`material.dart`) in Domain/Data layers.
*   **Source of Truth:** The **Feature Specification (Markdown)** is the authority on Business Rules.
*   **Logic Gaps:** If the Spec requires logic (filtering, sorting, pagination) that the abstract Data Source does not provide, the Repository **must** implement it in-memory.

---

## 9. Cheat Sheet: Where Does It Go?

| Scenario | Layer | Why? |
| :--- | :--- | :--- |
| **"Email format is invalid"** | **Domain** | Data invariant / Validity rule. |
| **"Show error text in red"** | **UI** | Visual formatting. |
| **"Retry HTTP request 3 times"** | **Repository** | Data access policy / Infrastructure strategy. |
| **"JSON parsing"** | **Datasource** | Technical serialization. |
| **"User cannot save while loading"** | **State Manager** | UX Guard Logic. |
| **"Free users can't upload video"** | **Domain** | Business limit rule. |
| **"Log 'purchase_failed' event"** | **Repository** | Cross-cutting concern. |
| **"Format date as 'Mon, Dec 22'"** | **State Manager** | UI-specific data transformation. |

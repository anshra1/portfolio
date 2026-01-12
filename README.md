# Professional Portfolio & Technical Blog

A high-performance, responsive Flutter application designed to serve as a comprehensive digital identity. It bridges the gap between a traditional CV and a technical blog, showcasing real-world projects alongside deep-dive technical insights.

## 🚀 Key Features

### 🔹 Projects Engine
*   **Ranked Search System:** Automatically prioritizes "Hero" and "Showcase" projects at the top of search results.
*   **Implicit Ranking:** No manual "featured" toggles; the architecture forces the best work to the top.
*   **Smart Repository:** In-memory logic engine handling advanced filtering, sorting, and pagination.

### 🔹 Knowledge Base (Articles)
*   **Distraction-Free Reading:** Optimized for consuming long-form technical content.
*   **Tiered Content:** Distinguishes between "Hero" tutorials and standard blog posts.
*   **Unified Architecture:** Shares the same "Smart Repo" pattern as the Projects feature for consistency.

## 🏗 Architecture & Design

This project adheres to **Strict Clean Architecture** principles, ensuring scalability and testability.

*   **Presentation Layer:** Flutter BLoC for state management.
*   **Domain Layer:** Pure Dart entities and use cases (Business Logic).
*   **Data Layer:** "Smart Repositories" that act as logic engines, creating a semantic shield between the UI and raw data sources.

### Core Patterns
*   **Logic Injection:** Repositories are not just pass-throughs; they contain the sorting and filtering intelligence.
*   **Implicit Ranking:** We use `DisplayTier` enums (Hero > Showcase > Standard) to enforce content hierarchy naturally.
*   **Facade Pattern:** Entities expose computed helpers (like `isFeatured`) to simplify UI logic while keeping the data model strict.

## 🛠 Tech Stack

*   **Framework:** Flutter (Mobile, Web, Desktop)
*   **State Management:** `flutter_bloc`
*   **Dependency Injection:** `get_it`
*   **Code Generation:** `freezed`, `json_serializable`, `build_runner`
*   **Functional Programming:** `fpdart` (Either types for error handling)
*   **Testing:** `flutter_test`, `mocktail`

## 📂 Project Structure

```text
lib/
├── features/
│   ├── projects/          # The Project Showcase Engine
│   ├── articles/          # The Technical Blog Engine
│   └── homepage/          # The Landing Hub
├── core/
│   ├── error/             # Centralized Error Handling (Failures & Exceptions)
│   ├── di/                # Dependency Injection Setup
│   └── common/            # Shared Enums and Utilities
└── docs/                  # Architectural Documentation & Feature Specs
```

## 🧪 Running Tests

This project maintains a high standard of code quality with comprehensive unit tests for Repositories and Use Cases.

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```
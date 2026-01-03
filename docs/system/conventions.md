# Conventions: Flutter Code & Style Guidelines

This document defines the micro-level standards for the project. **AI agents MUST apply these rules** to every line of code generated to ensure seamless integration with the existing codebase.

---

## 1. Feature Structure & Folders

Every feature **MUST** follow this strict directory structure. Flat files in the feature root are forbidden.

```text
lib/features/[feature_name]/
├── data/
│   ├── datasources/       # Remote & Local Data Sources
│   ├── models/            # DTOs (Freezed Models)
│   └── repositories/      # Repository Implementations
├── domain/
│   ├── entities/          # Pure Dart Classes
│   ├── repositories/      # Repository Contracts (Interfaces)
│   └── usecases/          # [feature]_usecase.dart (Grouped File)
└── presentation/
    ├── bloc/              # BLoCs & Cubits
    ├── pages/             # Full Screens (Scaffold)
    └── widgets/           # Feature-specific Components
```

---

## 2. Naming Conventions

### **Files & Folders**
*   **Format**: Always `snake_case`.
*   **Suffixes**:
    *   **BLoC**: `[feature]_bloc.dart`, `[feature]_event.dart`, `[feature]_state.dart`.
    *   **UI**: `[name]_page.dart` (screens) or `[name]_widget.dart` (components).
    *   **Data**: `[name]_model.dart`, `[name]_repository_impl.dart`.
    *   **Domain**: `[name]_usecase.dart` (for the grouped file).

### **Classes & Types**
*   **Format**: `PascalCase`.
*   **Widgets**: Use descriptive nouns (e.g., `PrimaryButton`, `UserAvatar`). **Avoid** generic names like `MyWidget`.
*   **BLoCs**: Must end in `Bloc` (e.g., `AuthBloc`).
*   **Use Cases**: `VerbNoun` (e.g., `GetProjects`).

### **Variables & Methods**
*   **Format**: `camelCase`.
*   **Private members**: **MUST** be prefixed with an underscore (e.g., `_isLoaded`, `_handleTap()`).
*   **Booleans**: Prefix with `is`, `has`, or `should` (e.g., `isLoading`, `hasError`).

---

## 3. Widget Structure & UI

### **Method Splitting**
To keep the `build` method readable, complex UI trees **MUST** be broken down into:
*   **Private Methods**: Use `Widget _build[PartName]()` for small, non-reusable sections.
*   **Separate Classes**: Extract to a new widget file if the component is reusable or exceeds 50 lines.

### **The Const Keyword**
*   **Mandatory**: Use `const` constructors wherever possible to optimize the widget tree and reduce rebuilds.

### **Styling**
*   **Themes**: **Never hardcode** colors or font sizes.
    *   *Correct*: `Theme.of(context).colorScheme.[color]` or `Theme.of(context).textTheme.[style]`.
*   **Spacing**: Use `Gap(16)` (if using the `gap` package) or `SizedBox(height: 16)` rather than padding for simple layout spacing.

---

## 4. Programming Patterns

### **Imports**
*   **Rule**: **Absolute imports** are mandatory for crossing layers or features. Relative imports are allowed **only** within the same directory.
*   **Forbidden**: `import '../../data/...'` (Do not traverse up parent directories with `..`).

**Order**:
1.  Flutter/Dart standard libraries.
2.  Third-party packages.
3.  Absolute project imports (`package:my_app/...`).
4.  Relative imports.

### **Async/Await**
*   **Standard**: Always use `async`/`await` instead of `.then()`.
*   **Parallel**: Use `Future.wait()` when multiple independent futures need to be awaited.

### **Constructors**
*   **Named Parameters**: Prefer Named Parameters for all widget constructors and complex data models to improve call-site readability.

---

## 5. Documentation & Comments

### **Doc Comments**
*   Use `///` for public-facing classes and methods.
*   Explain the **intent** of complex logic, not just *what* the code is doing.

### **TODOs**
*   **Format**: `// TODO: [Description] ([Username])`.
*   *Rule*: AI should only add TODOs when explicitly asked to leave a placeholder.

---

## 6. State Management (BLoC Specifics)

*   **Event Registration**: Always register events in the constructor using the `on<Event>((event, emit) => ...)` syntax.
*   **State Immutability**: States **MUST** be immutable (use `equatable` or `freezed`). Use `copyWith` for all transitions.
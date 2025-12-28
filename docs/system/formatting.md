# Formatting: Flutter & Dart Style Rules

This document defines the visual and structural rules for the codebase. **AI agents MUST follow these instructions** to ensure the code passes all CI/CD linting checks and matches the team's aesthetic standards.

---

## 1. Automatic Formatting

*   **Dart Format**: All code must be compatible with the `dart format` command.
*   **Line Length**: Maximum line length is **80 characters**. If a line exceeds this, it must be broken down according to standard Dart style guidelines.

---

## 2. Trailing Commas

Trailing commas are **MANDATORY** for all multi-line parameter lists and widget trees. This enables the Dart formatter to correctly indent the code.

*   **Widgets**: Always add a trailing comma after the last property in a constructor.
*   **Functions/Methods**: Use trailing commas for methods with more than two parameters.

```dart
// CORRECT
final widget = CustomWidget(
  title: 'Title',
  onPressed: () {},
); // Trailing comma here triggers correct indentation

// INCORRECT
final widget = CustomWidget(title: 'Title', onPressed: () {});
```

---

## 3. Import Organization

Imports must be sorted and grouped to prevent merge conflicts and improve readability.

**Order**:
1.  `dart:` imports.
2.  `package:flutter` imports.
3.  Third-party `package:` imports.
4.  Project-specific `package:portfolio` (absolute) imports.
5.  Relative imports (**allowed ONLY within the same directory**).

*Rule*: Leave one blank line between groups. Traverse-up imports (`import '../../...`) are strictly forbidden.

---

## 4. Class Member Ordering

Maintain a consistent order for class members:
1.  Static constants/variables.
2.  Instance variables (Final first, then non-final).
3.  Constructors (Const first).
4.  Factory constructors.
5.  `override` methods (e.g., `initState`, `didChangeDependencies`).
6.  The `build` method (for Widgets).
7.  Private helper methods (`_build...`).

---

## 5. UI Structure (Widget Trees)

*   **Nested Ternaries**: **FORBIDDEN**. If a UI logic requires more than a simple `condition ? true : false`, extract the logic into a separate private method or use an `if/else` block outside the `return` statement.
*   **Deep Nesting**: If a widget tree is nested more than 4 levels deep, the AI **MUST** extract a sub-component.
    *   Extract to **Private Method** (`_buildSection`) for non-reusable logic.
    *   Extract to **New Widget Class** (in `widgets/` folder) if logic exceeds 50 lines or is reusable.

---

## 6. Linter & Quality Rules

We strictly follow **both** `very_good_analysis` and `flutter_lints`. Key rules include:

*   **No Print Statements**: Use the **Talker** ecosystem for all logging.
*   **Prefer Const**: AI must identify and apply `const` to all possible constructors and literals.
*   **Sort Constructors First**: Always place the constructor before any other methods.
*   **No Unused Imports**: All imports must be used.

---

## 7. Comments & Spacing

*   **Vertical Spacing**: One blank line between methods. No blank lines at the start or end of a class body.
*   **Documentation**:
    *   Use `///` for public API documentation (Domain entities, Use Cases, Public Widgets).
    *   Use `//` for internal implementation notes.
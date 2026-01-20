# Flutter AI Code Generation Rules

This rule file defines the default assumptions and constraints that must be followed when generating Flutter code for this project.

---

## 1. Core Assumptions

### 1.1 Context-Driven Design

All UI styling must be derived from `BuildContext`.

Allowed sources:

* `Theme.of(context)`
* `Theme.of(context).colorScheme`
* `MediaQuery.of(context)`
* Context extensions (if defined)

Disallowed:

* Hardcoded colors
* Hardcoded font sizes
* Arbitrary padding values
* Inline `TextStyle` unless explicitly requested

---

## 2. Material Design Compliance

Flutter code must follow Material Design by default.

### 2.1 Widget Usage

Prefer Material widgets:

* `Scaffold`
* `AppBar`
* `ListTile` (No Kit equivalent yet)
* `Material`

**Avoid standard widgets when Kit equivalents exist**:
* `TextButton`, `ElevatedButton`, `OutlinedButton`, `IconButton` -> Use `Kit*Button`

Avoid:

* Custom-painted UI unless explicitly requested
* iOS-style UI unless explicitly requested

---

## 3. Design System Awareness

The project is assumed to have a centralized design system.

Rules:

* Do not invent colors, fonts, or spacing.
* Always connect UI styling to theme tokens.
* Assume dark/light mode support.

---

## 4. Layout Rules

### 4.1 Use Only Core Layout Widgets

Primary layout widgets:

* `Row`
* `Column`
* `Stack`
* `Expanded`
* `Flexible`
* `Align`
* `Center`
* `Padding`

Do not use complex layout abstractions unless necessary.

---

## 5. Component Architecture

### 5.1 Decomposition

* Break UI into reusable widgets.
* Each widget should have a single responsibility.

### 5.2 Naming

* Use semantic widget names.
* Avoid generic names like `Widget1`, `MyWidget`.

---

## 6. Production Code Standards

* No demo shortcuts
* No magic numbers
* No placeholder logic
* Clear variable naming
* Proper null-safety
* No unnecessary rebuilds

---

## 7. Override Rules

These rules may only be violated if the user explicitly asks for:

* Hardcoded styling
* Custom design system
* Non-Material UI
* Experimental layouts

---

## 8. Specific Design System Implementations

### 8.1 Typography
*   **Source**: `package:core_ui_kit` (exported via `Theme.of(context)`)
*   **Rule**: ALL text styles must use context extensions.
*   **Usage**: `style: context.headlineMedium`, `style: context.bodyLarge`.
*   **Forbidden**: `TextStyle(fontSize: ...)`
*   **📖 Full Guide**: [Typography AI Guide](./typography_ai_guide.md)

### 8.2 Density Tokens (Spacing, Radius, Sizes)
*   **Source**: `package:portfolio/core/theme/density/density.dart`
*   **Rule**: ALL spatial values (padding, margin, radius, icon sizes) must use density tokens.
*   **Usage**:
    *   Spacing: `context.spacing.md`, `context.spacing.lg`
    *   Radius: `context.radius.md`, `context.radius.lg`
    *   Sizes: `context.sizes.iconMd`
*   **📖 Full Guide**: [Density Tokens AI Guide](./density_tokens_ai_guide.md)

### 8.3 Button System
*   **Source**: `package:core_ui_kit`
*   **Rule**: Use the designated Kit components for all buttons.
*   **Components**:
    *   `KitPrimaryButton`
    *   `KitSecondaryButton`
    *   `KitTertiaryButton`
    *   `KitOutlineButton`
    *   `KitGhostButton`
    *   `KitDestructiveButton`
    *   `KitLinkButton`
    *   `KitSocialButton`
    *   `KitIconButton`

### 8.4 Colors
*   **Source**: `Theme.of(context).colorScheme`
*   **Rule**: Use semantic color roles. **Follow Material Design 3 color guidelines.**
*   **Strict Adherence**: Material Design 3 roles (`primary`, `onPrimary`, `surface`, `onSurface`, `onSurfaceVariant`, `outline`, `error`, etc.).
*   **Forbidden**: Hardcoded `Color(0xFF...)` or `Colors.red` values.

### 8.5 Cards
*   **Source**: `package:core_ui_kit`
*   **Rule**: Use `KitCard` instead of `Card`.

### 8.6 Standard Imports
Always include these when building UI:
```dart
import 'package:portfolio/core/theme/theme.dart'; // or specific typography/density paths
import 'package:core_ui_kit/core_ui_kit.dart';
```

---

## 9. State Management (BLoC)

### 9.1 Architecture
*   **Pattern**: BLoC (Business Logic Component) with `flutter_bloc`.
*   **Rule**: UI widgets must NEVER contain business logic. All state and logic must reside in BLoCs/Cubits.

### 9.2 Widget-BLoC Relationship
*   Use `BlocProvider` to inject BLoCs into the widget tree.
*   Use `BlocBuilder` for rebuilding UI based on state.
*   Use `BlocListener` for side effects (navigation, snackbars, etc.).
*   Use `BlocConsumer` when both rebuilding and side effects are needed.


### 9.3 Forbidden
*   `setState()` for business logic.
*   Direct state mutation.
*   BLoC logic inside widgets.

---

## 10. Responsive Design

### 10.1 Breakpoint System
*   **Source**: `package:portfolio/core/responsive/...`
*   **Rule**: Use breakpoint-aware widgets and extensions for adaptive layouts.

### 10.2 Responsive Text
*   **Source**: `ResponsiveTextStyle` from the core responsive module.
*   **Usage**: `style: context.headlineMedium` (auto-resolves based on breakpoint).
*   **Fallback**: Use `.value` for static contexts without `BuildContext`.

### 10.3 Layout Adaptation
*   Use `LayoutBuilder` or custom breakpoint widgets for layout switching.
*   Design mobile-first, then add tablet/desktop adaptations.
*   Prefer `Expanded`/`Flexible` over fixed widths for fluid layouts.

### 10.4 Forbidden
*   Hardcoded widths/heights for responsive containers.
*   Ignoring breakpoints for major layout decisions.

---

## 11. AI Behavior Rules

### 11.1 Goal Declaration
*   **Rule**: Whenever creating UI code, **state the goal first and nothing else**.
*   **Format**: "My goal is [action]..."

---

## 12. Mental Model

You are not generating UI randomly.
You are extending an existing design system.

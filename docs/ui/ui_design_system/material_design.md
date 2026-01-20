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
*   **Source**: `package:portfolio/core/theme/typography/typography.dart` (exported via `Theme.of(context)`)
*   **Rule**: ALL text styles must use context extensions.
*   **Usage**: `style: context.headlineMedium`, `style: context.bodyLarge`.
*   **Forbidden**: `TextStyle(fontSize: ...)`

### 8.2 Density Tokens (Spacing, Radius, Sizes)
*   **Source**: `package:portfolio/core/theme/density/density_extensions.dart`
*   **Rule**: ALL spatial values (padding, margin, radius, icon sizes) must use density tokens.
*   **Usage**:
    *   Spacing: `context.spacing.md`, `context.spacing.lg`
    *   Radius: `context.radius.md`, `context.radius.full`
    *   Sizes: `context.sizes.iconMd`

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
*   **Rule**: Use semantic color roles.
*   **Strict Adherence**: Material Design 3 roles (`primary`, `onPrimary`, `surface`, `onSurfaceVariant`, etc.).

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

## 9. AI Behavior Rules

### 9.1 Goal Declaration
*   **Rule**: Whenever creating UI code, **state the goal first and nothing else**.
*   **Format**: "My goal is [action]..."

---

## 10. Mental Model

You are not generating UI randomly.
You are extending an existing design system.

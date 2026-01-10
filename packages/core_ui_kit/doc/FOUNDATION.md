# Foundation System

The Foundation layer is the bedrock of the `core_ui_kit`. It contains immutable design tokens that define the structural and visual physics of the design system. 

All tokens in this layer use the **`Kit`** prefix to ensure clarity and avoid namespace collisions with Flutter's material or cupertino libraries.

## Directory Structure

```text
lib/src/foundation/
├── core/           # Structural tokens (Spacing, Radii, Shadows, etc.)
├── brand/          # Visual identity (Icons, soon: Typography/Colors)
├── motion/         # Animation physics (Durations, Curves)
├── accessibility/  # User-centered constraints (Tap targets, contrast)
├── platform/       # System-specific behaviors (Haptics)
└── foundation.dart # Main barrel file
```

---

## 1. Core (`core/`)
Mathematical constants that define the "skeleton" of the UI.

- **`KitSpacing`**: Standardized margins and paddings.
  - *Values:* `xs: 4`, `sm: 8`, `md: 16`, `lg: 24`, `xl: 32`, `xxl: 48`.
- **`KitRadius`**: Corner roundness for containers and buttons.
  - *Values:* `sm: 8`, `md: 12`, `lg: 16`, `xl: 24`, `full: 999`.
- **`KitShadows`**: Standardized elevation and depth effects.
- **`KitBreakpoints`**: Screen width thresholds for responsive layouts.
- **`KitOpacity`**: Transparency levels for disabled or decorative elements.

## 2. Brand (`brand/`)
Tokens that convey the visual identity.

- **`KitIcons`**: Centralized icon constants used throughout the kit.

## 3. Motion (`motion/`)
Defines how the UI moves and feels.

- **`KitDurations`**: Standardized animation lengths (e.g., `fast`, `standard`, `slow`).
- **`KitCurves`**: Standardized easing curves (e.g., `standard`, `decelerate`).

## 4. Accessibility (`accessibility/`)
Ensures the UI is usable by everyone.

- **`KitAccessibility`**: Defines minimum hit targets and scale factors.
  - *Example:* `minTargetSize = 44.0`.

## 5. Platform (`platform/`)
Device-specific interactions.

- **`KitHaptics`**: Feedback patterns for iOS and Android.

---

## Usage Guidelines

1. **Import via Barrel:** Always import foundation tokens through the main package export or the foundation barrel.
   ```dart
   import 'package:core_ui_kit/core_ui_kit.dart';
   // OR
   import 'package:core_ui_kit/src/foundation/foundation.dart';
   ```

2. **No Hardcoding:** Never use raw numbers for margins, padding, or radii. Always use a `Kit` token.
   ```dart
   // ❌ Bad
   Padding(padding: EdgeInsets.all(16.0))

   // ✅ Good
   Padding(padding: EdgeInsets.all(KitSpacing.md))
   ```

3. **Immutable:** Tokens are `static const`. They do not change at runtime. For dynamic values that change based on theme (Dark/Light), use the **Theme** layer instead.

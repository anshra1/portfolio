# Semantic Text System Plan (Static Typography + Dynamic Color)

## 1. Core Philosophy
This system decouples **Typography Structure** (Font, Weight, Size) from **Appearance** (Color).
- **Structure**: Defined statically in `KitTypography`. These values are constant and only change based on screen size (Responsiveness).
- **Appearance**: Derived dynamically from `Theme.of(context).colorScheme`. This ensures text is always visible (e.g., Black in Light Mode, White in Dark Mode).

## 2. Architectural Layers

### Layer 1: The Tokens (`KitTypography`)
A static class containing `ResponsiveTextStyle` definitions.
- **Location**: `lib/src/themes/tokens/typography_tokens.dart`
- **Role**: Defines the "Shape" of text.
- **Example**: `static const titleLarge = ResponsiveTextStyle(...)` (No color defined).

### Layer 2: The Engine (`KitBaseText`)
The low-level widget.
- **Location**: `lib/src/widgets/atoms/text/kit_base_text.dart`
- **Logic**:
  1. Accepts a `ResponsiveTextStyle` (from Layer 1).
  2. **Responsiveness**: Calls `.resolve(context)` to get the sized `TextStyle`.
  3. **Color Strategy**:
     - If `color` is provided explicitly -> Use it.
     - If `color` is null -> Default to `Theme.of(context).colorScheme.onSurface` (or standard text color).
  4. Merges the resolved style + resolved color.

### Layer 3: The API (`KitText`)
The developer-facing widget.
- **Location**: `lib/src/widgets/atoms/text/kit_text.dart`
- **Pattern**: Factory constructors mapping to Layer 1 tokens.
- **Usage**:
  ```dart
  KitText.titleLarge("Hello") // Uses default onSurface color
  KitText.bodyMedium("Error", color: context.colorScheme.error) // Overrides color
  ```

## 3. Implementation Steps

### Step 1: Define Typography Tokens
Create `lib/src/themes/tokens/typography_tokens.dart`.
- Define static `ResponsiveTextStyle` constants for:
  - `display` (Large, Medium, Small)
  - `headline` (Large, Medium, Small)
  - `title` (Large, Medium, Small)
  - `body` (Large, Medium, Small)
  - `label` (Large, Medium, Small)

### Step 2: Create the Engine
Create `lib/src/widgets/atoms/text/kit_base_text.dart`.
- Implement `build` method.
- **Crucial**: Ensure `color ?? Theme.of(context).colorScheme.onSurface` is applied correctly.

### Step 3: Create the Public Widget
Create `lib/src/widgets/atoms/text/kit_text.dart`.
- Create factory constructors:
  ```dart
  factory KitText.titleLarge(String data, {Color? color}) => 
      KitText(data, style: KitTypography.titleLarge, color: color);
  ```

## 4. Advantages
- **Clean Separation**: Typography definitions don't bloat the Theme.
- **Dark Mode Ready**: Colors automatically switch because they aren't hardcoded in the tokens.
- **Performance**: Static tokens are efficient; only the widget resolves them.
# Button System Documentation for

A robust, state-driven button system for the `core_ui_kit`.

## Overview

The button system is built on a compositional architecture using `KitBaseButton` as the foundation. It provides semantic variants that handle their own styling while sharing common behaviors for states, sizes, and layout.

## Key Features

- **State-Driven:** Uses an explicit `KitButtonState` enum (`enabled`, `disabled`, `loading`).
- **Standardized Sizing:** T-shirt sizing via `KitButtonSize` (`small`, `medium`, `large`).
- **Declarative Logic:** Uses `WidgetStateProperty` for hover, focus, and disabled effects.
- **Built-in Icons:** Native support for `leading` and `trailing` widgets with standardized spacing.
- **Elevation Management:** Elevation automatically drops to zero when buttons are inactive/loading.
- **Centralized Tokens:** All radii, padding, and elevation values are managed in `KitButtonTokens`.

## Components

### 1. KitPrimaryButton
High-emphasis button for main actions. Uses `primary` color and `elevationPrimary`.

### 2. KitSecondaryButton
Medium-emphasis action. Uses `secondaryContainer` colors and is flat by default.

### 3. KitDestructiveButton
For dangerous actions (Delete/Remove).
- **Default:** Solid error color with `elevationPrimary`.
- **Outlined:** Transparent with an error-colored border.

### 4. KitOutlineButton
Medium-low emphasis. Transparent background with a themed border.

### 5. KitGhostButton
Low-emphasis text-only button. No background or border.

### 6. KitLinkButton
Hyperlink style using `TextButton` foundation for perfect inline alignment.

### 7. KitIconButton
Standardized circular or square icon buttons. Wraps `IconButton` but adheres to kit `iconSize`.

### 8. KitSocialButton
Standardized login buttons for Google, Apple, Facebook, and GitHub. Uses a balanced `Row` layout to ensure branding icons and text are perfectly aligned without overlap.

## Usage Example

```dart
KitPrimaryButton(
  onPressed: _saveData,
  state: _isSaving ? KitButtonState.loading : KitButtonState.enabled,
  size: KitButtonSize.large,
  leading: Icon(Icons.save),
  child: Text("Save Changes"),
)
```

# Button Design Tokens

This document records the centralized design tokens used across the `core_ui_kit` button system.

## Tokens Overview

| Token Name | Value | Description |
| :--- | :--- | :--- |
| `radius` | `8.0` | The standard corner radius for all button types. |
| `paddingBase` | `horizontal: 24, vertical: 12` | Default internal spacing for primary and secondary buttons. |
| `paddingCompact` | `horizontal: 16, vertical: 12` | Reduced internal spacing for ghost and minimal buttons. |
| `iconSize` | `20.0` | The standard size for icons when used inside buttons. |

## Usage

Reference these tokens using the `KitButtonTokens` class to ensure visual consistency:

```dart
KitBaseButton(
  borderRadius: BorderRadius.circular(KitButtonTokens.radius),
  padding: KitButtonTokens.paddingBase,
  // ...
)
```

# Button Design Tokens

This document records the centralized design tokens used across the `core_ui_kit` button system.

## 1. Corner Radius
| Token | Value | Description |
| :--- | :--- | :--- |
| `radius` | `8.0` | Standard corner radius for all button types. |

## 2. Padding (Sizes)
| Token | Value | Size Enum | Description |
| :--- | :--- | :--- | :--- |
| `paddingSmall` | `16h, 8v` | `small` | Compact padding for dense UIs. |
| `paddingMedium`| `24h, 12v` | `medium`| Standard padding (Default). |
| `paddingLarge` | `32h, 16v` | `large` | Prominent padding for CTAs. |
| `paddingCompact`| `16h, 12v` | - | Used for special minimal buttons. |

## 3. Elevation (Depth)
| Token | Value | Description |
| :--- | :--- | :--- |
| `elevationPrimary`| `2.0` | Default elevation for Primary and Destructive buttons. |
| `elevationNone` | `0.0` | Flat style used for Secondary, Ghost, and Outlined buttons. |

> **Note:** Elevation automatically drops to `0.0` globally when the button state is `loading` or `disabled`.

## 4. Icons
| Token | Value | Description |
| :--- | :--- | :--- |
| `iconSize` | `20.0` | Standard size for icons used inside buttons. |
| `gap` | `8.0` | The fixed spacing between an icon and the child text. |

## 5. Typography
| Token | Style | Description |
| :--- | :--- | :--- |
| `textStyle` | `labelLarge` | The material text style used for button labels. |

## 6. Color Roles
| Button Type | Background | Foreground | Border |
| :--- | :--- | :--- | :--- |
| **Primary** | `primary` | `onPrimary` | None |
| **Secondary** | `secondaryContainer` | `onSecondaryContainer` | None |
| **Destructive** | `error` | `onError` | None |
| **Outline** | Transparent | `primary` | `primary` (1px) |
| **Ghost** | Transparent | `primary` | None |
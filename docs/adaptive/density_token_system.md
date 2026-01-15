# Proposal: Adaptive Density Token System

## Overview
As we scale the portfolio across mobile, tablet, and desktop, we need a formal system to manage "UI Density." This proposal introduces a **Density Token System** that allows the interface to dynamically "squish" or "expand" based on the environment (screen size, input method, or user preference) without changing the underlying layout logic.

## 1. The Problem: "The Density Gap"
Our current adaptive strategy (as defined in `read_it.md`) focuses on layout flexibility and text scaling. However, we lack a system for **Vertical and Horizontal Compactness**.
*   **Mobile:** Needs "Comfortable" targets (48px+) for touch.
*   **Desktop:** "Comfortable" looks sparse and unprofessional; it requires "Compact" spacing for mouse precision.
*   **In-Between:** Resized browser windows or iPad Split Views create "The Awkward Valley" where a mobile layout is too big, but a desktop layout doesn't fit.

## 2. Proposed Solution: The Three-Tier System
We will implement three distinct density modes:

| Mode | Target | Primary Characteristic |
| :--- | :--- | :--- |
| **Comfortable** | Mobile / Touch | High whitespace, large touch targets, readability-first. |
| **Compact** | Desktop / Web | Reduced padding, smaller icons, efficiency-first. |
| **Dense** | Data-Heavy Views | Minimal whitespace, maximizing information density. |

### The "Squish" Behavior
Instead of triggering a "Mobile Breakpoint" (e.g., hiding the sidebar) at 1000px, we trigger a **Density Shift** to "Compact" at 1100px. This allows the full desktop layout to remain functional in narrower windows by "vacuum-packing" the internal whitespace.

## 3. Architectural Pattern: ThemeExtension
To ensure this is production-grade and portable across your projects, we will use the `ThemeExtension` pattern.

### A. Semantic Token Mapping
We will separate **Primitive Values** from **Semantic Intent**.
*   `spacing.md` (Semantic) → Maps to `16.0` in Comfortable.
*   `spacing.md` (Semantic) → Maps to `8.0` in Compact.

### B. The "Smart Backpack" Structure
The system will be contained within three modular files:
1.  `density_enums.dart`: Defines the `DensityMode`.
2.  `density_tokens.dart`: Immutable data classes for `Spacing`, `Radius`, `Sizes`, and `Typography`.
3.  `app_density.dart`: The `ThemeExtension` that binds everything to `ThemeData`.

## 4. Developer Experience (DX)
To ensure high adoption and clean code, we will implement `BuildContext` extensions.

**Usage Example:**
```dart
// The UI code remains agnostic of the current mode
Padding(
  padding: EdgeInsets.all(context.spacing.md),
  child: Text(
    "Project Title",
    style: context.dText.h2,
  ),
)
```

## 5. Integration with Existing Adaptive Docs
This system directly supports the principles in:
*   **`read_it.md`**: By using `context.spacing`, we avoid "Fixed Heights." Containers grow naturally but start from a smaller baseline in Compact mode.
*   **`asset_management.md`**: Icon sizes will be tokenized (`context.sizes.iconMd`), ensuring SVGs scale perfectly with the density shift.

## 6. Portability (Solo Dev Focus)
The entire folder `lib/core/theme/density/` is designed to be a "Drop-in" asset. It has zero dependencies on external packages and can be moved to any new Flutter project instantly.

---
**Status:** Pending Review
**Next Steps:** Implement Phase 1 (Tokens and Enums).

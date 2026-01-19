# Presentation Layer Folder Structure

This document defines the canonical folder structure for the Presentation Layer in a Clean Architecture Flutter project.

---

## Overview

The presentation layer is organized by **scope** and **widget type**, with clear separation between page-level constructs and component-level widgets.

```
presentation/
├── models/                # ViewModels
├── bloc/                  # State management
├── pages/                 # _page (entry points)
├── page_layout/           # Page-level _layout variants
└── widgets/               # All component widgets
    ├── widget_layout/     # Component-level _layout variants
    ├── visuals/           # _visual
    ├── units/             # _unit
    ├── views/             # _view (data connectors)
    ├── actions/           # _action
    ├── controls/          # _control
    └── inputs/            # _input
```

---

## Layout Scope Rules

`_layout` widgets exist at **two distinct levels**:

| Scope | Location | Purpose | Example |
|-------|----------|---------|---------|
| **Page-level** | `page_layout/` | How the entire page arranges based on breakpoint | `home_page_web_layout.dart` |
| **Component-level** | `widgets/widget_layout/` | How a component arranges internally | `order_card_expanded_layout.dart` |

### Page-Level Layouts

Located in `presentation/page_layout/`, these define **how the page structure changes** across breakpoints:

```
page_layout/
├── orders_page_web_layout.dart      # 3-column grid, sidebar
├── orders_page_tablet_layout.dart   # 2-column, collapsible sidebar
└── orders_page_mobile_layout.dart   # Single column, bottom nav
```

**Naming:** `{feature}_page_{breakpoint}_layout.dart`

### Component-Level Layouts

Located in `presentation/widgets/widget_layout/`, these define **how a component's internal structure changes**:

```
widgets/widget_layout/
├── order_card_expanded_layout.dart   # Horizontal arrangement
├── order_card_compact_layout.dart    # Vertical, stacked
└── stats_row_wide_layout.dart        # Side-by-side stats
```

**Naming:** `{component}_{variant}_layout.dart`

> **Key Principle:** Components remain size-agnostic. The **parent layout** decides which component layout variant to use.

---

## Full Structure Example

```
lib/
├── core/
│   └── presentation/
│       ├── models/                    # Shared ViewModels
│       │   └── app_user_view_model.dart
│       └── widgets/
│           ├── widget_layout/         # Shared component layouts
│           │   └── app_card_wide_layout.dart
│           ├── visuals/
│           │   ├── app_logo_visual.dart
│           │   └── app_divider_visual.dart
│           ├── units/
│           │   ├── app_avatar_unit.dart
│           │   └── app_stat_row_unit.dart
│           ├── actions/
│           │   └── app_logout_action.dart
│           ├── controls/
│           │   └── app_theme_switch_control.dart
│           └── inputs/
│               └── app_search_input.dart
│
├── features/
│   └── orders/
│       ├── data/                      # Clean Architecture: Data Layer
│       ├── domain/                    # Clean Architecture: Domain Layer
│       └── presentation/              # Clean Architecture: Presentation Layer
│           │
│           ├── models/                # Feature-specific ViewModels
│           │   └── order_view_model.dart
│           │
│           ├── bloc/                  # State management
│           │   ├── orders_bloc.dart
│           │   ├── orders_event.dart
│           │   └── orders_state.dart
│           │
│           ├── pages/                 # _page widgets (entry points)
│           │   └── orders_page.dart
│           │
│           ├── page_layout/           # Page-level _layout variants
│           │   ├── orders_page_web_layout.dart
│           │   ├── orders_page_tablet_layout.dart
│           │   └── orders_page_mobile_layout.dart
│           │
│           └── widgets/               # All components
│               ├── widget_layout/     # Component-level _layout variants
│               │   ├── order_card_expanded_layout.dart
│               │   └── order_card_compact_layout.dart
│               ├── visuals/
│               │   └── orders_empty_visual.dart
│               ├── units/
│               │   ├── order_card_unit.dart
│               │   └── order_status_unit.dart
│               ├── views/
│               │   ├── orders_list_view.dart
│               │   └── order_details_view.dart
│               ├── actions/
│               │   ├── order_delete_action.dart
│               │   └── order_details_action.dart
│               ├── controls/
│               │   └── order_filter_control.dart
│               └── inputs/
│                   └── order_search_input.dart
│
└── packages/
    └── core_ui_kit/                   # kit_ primitives
        └── lib/
            └── src/
                └── widgets/
                    ├── kit_button.dart
                    ├── kit_card.dart
                    └── kit_text_field.dart
```

---

## Prefix Rules

| Folder | Contains | Prefix |
|--------|----------|--------|
| `core/presentation/widgets/` | App-wide shared components | `app_*` |
| `features/{name}/presentation/widgets/` | Feature-specific components | `{feature}_*` |
| `packages/core_ui_kit/` | Design system primitives | `kit_*` |

---

## Widget Type → Folder Mapping

| Widget Type | Folder | Example |
|-------------|--------|---------|
| `_page` | `pages/` | `orders_page.dart` |
| `_layout` (page) | `page_layout/` | `orders_page_mobile_layout.dart` |
| `_layout` (component) | `widgets/widget_layout/` | `order_card_expanded_layout.dart` |
| `_view` | `widgets/views/` | `orders_list_view.dart` |
| `_visual` | `widgets/visuals/` | `orders_empty_visual.dart` |
| `_unit` | `widgets/units/` | `order_card_unit.dart` |
| `_action` | `widgets/actions/` | `order_delete_action.dart` |
| `_control` | `widgets/controls/` | `order_filter_control.dart` |
| `_input` | `widgets/inputs/` | `order_search_input.dart` |

---

## Quick Decision Guide

```
Where does my widget go?

Is it a screen entry point?
  → pages/

Is it a page-level responsive variant?
  → page_layout/

Is it a component-level responsive variant?
  → widgets/widget_layout/

Otherwise, by suffix:
  _visual  → widgets/visuals/
  _unit    → widgets/units/
  _view    → widgets/views/
  _action  → widgets/actions/
  _control → widgets/controls/
  _input   → widgets/inputs/
```

---

**See also:** [Widget Naming System](widget_naming_system.md) for classification rules and conventions.

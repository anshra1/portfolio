# Presentation Layer Folder Structure

This document defines the canonical folder structure for the Presentation Layer in a Clean Architecture Flutter project.

---

## Overview

The presentation layer is organized by **scope** and **section**.
- **Pages** are the entry points.
- **Layouts** handle responsiveness.
- **Sections** group related widgets together.

```
presentation/
├── models/                # ViewModels
├── bloc/                  # State management
├── pages/                 # _page (entry points)
├── layouts/               # Page-level _layout variants
└── widgets/               # Component-level widgets
    ├── hero_section/      # Domain-specific section
    ├── projects_section/  # Domain-specific section
    ├── shared/            # Reusable keys reused across sections
    └── overlays/          # Global overlays (Drawers, Dialogs)
```

---

## 1. Top-Level Organization

| Folder | Content | Suffix |
|--------|---------|--------|
| `pages/` | Screen entry points (Route targets) | `_page.dart` |
| `layouts/` | Responsive page variants | `_layout.dart` |
| `widgets/` | All UI components | (Various) |

---

## 2. Widget Folder Strategy: "Section-Based"

Unlike traditional Clean Architecture which groups by type (visuals/actions), we group by **Section (Domain)**.
Web pages are built in large horizontal strips (Hero, Features, Footer). Code should match this structure.

### Structure Rule:
- **Complex Pages:** Use **Section Folders** (e.g., `hero_section/`) to group related widgets.
- **Simple Pages:** You can place widgets directly in `widgets/` or a flat folder if no sections exist.
- **Shared Widgets:** If used in >1 section, move to `shared/`.

### 2.1 The "No-Section" Rule (Direct Composition)

Not every page needs `_section` widgets. For simpler pages (e.g., Login, Settings), the **Page Layout** can directly compose `_visual`, `_unit`, and `_action` widgets.

**Scenario:**
- **Landing Page:** `Page` → `Layout` → `HeroSection` → `HeroTitleVisual`
- **Login Page:** `Page` → `Layout` → `LoginVisual`, `LoginAction` (No "LoginSection" needed)

### Example Structure:

```
features/homepage/presentation/widgets/
├── hero_section/          <-- Use [SectionName] folder
│   ├── hero_section.dart      # The composite container (_section)
│   ├── hero_title_visual.dart # Parts of this section
│   ├── hero_cta_action.dart
│   └── hero_layout.dart       # Internal layout if needed
│
├── projects_section/
│   ├── projects_section.dart
│   └── project_card_unit.dart
│
└── shared/                <-- Reusable across sections
    └── section_header_unit.dart
```

---

## 3. Widget Type → Folder Mapping

| Widget Class | Folder Location |
|--------------|-----------------|
| `HeroSection` (`_section`) | `widgets/hero_section/` |
| `HeroTitleVisual` (`_visual`) | `widgets/hero_section/` |
| `ProjectCardUnit` (`_unit`) | `widgets/projects_section/` |
| `GenericButton` (`_unit`) | `widgets/shared/` |

---

## 4. Renamed/Refactored Concepts

- **Page Layouts:** Moved from `page_layout/` to `layouts/` (simpler name).
- **Sections:** New concept. High-level containers are now `_section` (e.g., `HeroSection`).
- **Visuals/Actions/Units Directories:** **DEPRECATED**. Do not create folders named `visuals`, `actions`, etc. inside `widgets/`. Use section names.

---

**See also:** [Widget Naming System](widget_naming_system.md) for strict class naming rules (which still apply regardless of folder location).

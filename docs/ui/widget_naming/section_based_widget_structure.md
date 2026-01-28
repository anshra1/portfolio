# Section-Based Widget Structure

This document defines the folder structure and organization for Section-Based widgets in the Presentation Layer.

---

## Overview

**Sections** group related widgets together by domain.

## Widget Folder Strategy: "Section-Based"

Unlike traditional Clean Architecture which groups by type (visuals/actions), we group by **Section (Domain)**.
Web pages are built in large horizontal strips (Hero, Features, Footer). Code should match this structure.

### Structure Rule:
- **Complex Pages:** Use **Section Folders** (e.g., `hero_section/`) to group related widgets.
- **Shared Widgets:** If used in >1 section, move to `shared/`.

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

## Widget Type → Folder Mapping

| Widget Class | Folder Location |
|--------------|-----------------|
| `HeroSection` (`_section`) | `widgets/hero_section/` |
| `HeroTitleVisual` (`_visual`) | `widgets/hero_section/` |
| `ProjectCardUnit` (`_unit`) | `widgets/projects_section/` |
| `GenericButton` (`_unit`) | `widgets/shared/` |

---

## Refactored Concepts

- **Sections:** New concept. High-level containers are now `_section` (e.g., `HeroSection`).
- **Visuals/Actions/Units Directories:** **DEPRECATED**. Do not create folders named `visuals`, `actions`, etc. inside `widgets/`. Use section names.

---

**See also:**
- [Page-Based Widget Structure](page_based_widget_structure.md) for page and layout organization.
- [Widget Naming System](widget_naming_system.md) for strict class naming rules.

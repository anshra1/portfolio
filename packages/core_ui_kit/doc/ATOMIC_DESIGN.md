# Atomic Design Guide

This project follows the **Atomic Design** methodology for organizing UI components. This approach ensures scalability, consistency, and a clear hierarchy of complexity.

## The Hierarchy

We divide our components into five distinct levels, mapped to our folder structure in `lib/src/widgets/`:

### 1. Atoms (`src/widgets/atoms/`)
Atoms are the basic building blocks of our UI. They cannot be broken down further without losing their functionality.
- **Buttons:** `KitPrimaryButton`, `KitGhostButton`, etc.
- **Inputs:** `CoreTextField`.
- **Toggles:** `CoreSwitch`.
- **Feedback:** `CoreLoader`.
- **Layout:** `CoreDivider`.

### 2. Molecules (`src/widgets/molecules/`)
Molecules are simple groups of atoms functioning together as a unit. They are the first step toward building complex components.
- **Cards:** `CoreCard` (A container molecule).
- **Feedback:** `CoreDialog`, `CoreToast`.
- **Search Bar:** (Future) A combination of an Input Atom and an Icon Button Atom.

### 3. Organisms (`src/widgets/organisms/`)
Organisms are complex UI sections composed of groups of molecules and/or atoms. They often form distinct sections of an interface.
- **Examples:** Navigation bars, complex forms, headers, or card grids.

### 4. Templates (`src/widgets/templates/`)
Templates are page-level layout structures that define the arrangement of organisms and molecules. They are essentially wireframes with placeholders.
- **Scaffolds:** `CoreScaffold`.

### 5. Pages (`src/widgets/pages/`)
Pages are specific implementations of templates with real content and data. This is what the end-user eventually sees.

---

## Folder Structure

```text
lib/src/widgets/
├── atoms/          # Basic building blocks (Buttons, Inputs, etc.)
├── molecules/      # Simple combinations of atoms (Cards, Dialogs)
├── organisms/      # Complex sections (Headers, Forms)
├── templates/      # Layout structures (Scaffolds)
└── pages/          # Full screens with data
```

## Guidelines for New Components

1.  **Check for existing Atoms:** Before building a new component, see if the basic building blocks already exist.
2.  **Complexity Test:** If a component contains multiple atoms working together, it's likely a **Molecule**. If it manages layout for a whole section of a screen, it's an **Organism**.
3.  **No Direct Token Access:** Components should rely on the **Foundation layer** (`src/foundation/`) or **Theme** rather than hardcoding raw design tokens.
4.  **Export everything:** Ensure new components are exported in `lib/core_ui_kit.dart`.

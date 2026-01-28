# Page-Based Widget Structure

This document defines the folder structure and organization for Pages and Layouts in the Presentation Layer.

---

## Overview

The presentation layer is organized by **scope**:
- **Pages** are the entry points.
- **Layouts** handle responsiveness.

## 1. Top-Level Organization

| Folder | Content | Suffix |
|--------|---------|--------|
| `pages/` | Screen entry points (Route targets) | `_page.dart` |
| `layouts/` | Responsive page variants | `_layout.dart` |
| `widgets/` | All UI components | (Various) |

---

## 2. Direct Composition (The "No-Section" Rule)

Not every page needs `_section` widgets. For simpler pages (e.g., Login, Settings), the **Page Layout** can directly compose `_visual`, `_unit`, and `_action` widgets without needing a dedicated section folder.

### Scenario:
- **Login Page:** `Page` → `Layout` → `LoginVisual`, `LoginAction` (No "LoginSection" needed)

### When to use:
- **Simple Pages:** You can place widgets directly in `widgets/` or a flat folder if no sections exist.

---

**See also:**
- [Section-Based Widget Structure](section_based_widget_structure.md) for complex pages.
- [Widget Naming System](widget_naming_system.md) for strict class naming rules.

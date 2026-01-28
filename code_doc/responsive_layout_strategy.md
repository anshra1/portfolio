# Responsive Layout Strategy & Decisions

## The "Constraint vs. Grid" Pattern

**Date:** 2026-01-28
**Context:** `ProjectListPage` Refactoring

### The Problem
When using `ResponsiveGridLayout` (or similar grid systems) on large screens (Desktop, Ultrawide), we observed that content would stretch uncomfortably.
*   The Grid correctly calculated 3 columns.
*   However, with a screen width of 2560px, each "column" became ~800px wide.
*   This resulted in massive, stretched cards that looked broken and were hard to read.

### The Component Responsibility: `ResponsiveGridLayout`
It is crucial to understand what `ResponsiveGridLayout` does and does **not** do:
*   ✅ **DOES**: Determine how many columns to show based on breakpoints (e.g., 1 on Mobile, 3 on Desktop).
*   ✅ **DOES**: Calculate the width of *one item* by dividing the available space.
*   ❌ **does NOT**: Limit the total width of the grid itself. It greedily consumes 100% of the parent's width.

### The Solution: Page-Level Constraints
To maintain visual balance and correct element sizing, we **must** constrain the width *before* it reaches the grid component. This is a "Container" pattern common in web design.

**The Pattern:**
Wrap page content (or specific sections) in a `ResponsiveLayoutBuilder` that applies a `ConstrainedBox` only when necessary.

```dart
ResponsiveLayoutBuilder(
  builder: (context, size) {
    return Center( // 1. Center the constrained content
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // 2. Limit width on large screens (Web/Tablet)
          // 3. Keep fluid (infinity) on Mobile for full edge-to-edge
          maxWidth: size.isMobile 
              ? double.infinity 
              : context.sizes.maxContainerWidth, // e.g. 1200px
        ),
        child: MyGridComponent(), 
      ),
    );
  }
)
```

### Why not inside the Component?
We avoid putting this `ConstrainedBox` *inside* `ResponsiveGridLayout` or `ProjectListGridView` to keep those components pure and reusable. 
*   They should fill whatever container they are placed in (e.g., a sidebar, a modal, or a full page).
*   The **Parent Page** owns the responsibility of defining the "canvas" size.

### Implementation Example
See `lib/features/projects/presentation/pages/project_list_page.dart`.

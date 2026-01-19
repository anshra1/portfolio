# Component Design Rules

> **Core Principle**: A component must not decide its own size. The layout must decide the size.

---

## Widget System Mapping

The following **widget categories** from the [Widget Naming System](../widget_naming_system.md) are considered **"components"** and **MUST** follow all rules in this document:

| Widget Category | Suffix | Component Type |
|----------------|--------|----------------|
| **Static Widget** | `_visual` | Pure static components with no parameters |
| **Reusable Widget** | `_unit` | Display-only components that accept values |
| **User Action** | `_action` | Components that trigger logic layer intents |
| **Local Control** | `_control` | Components with ephemeral UI state |
| **Controller Adapter** | `_input` | Components that manage UI controllers |

**NOT components** (exempt from these rules):
- ❌ `_view` - State projection layer (follow [View Rules](view.md))
- ❌ `_layout` - Responsive layouts (follow [Layout Rules](layout.md))
- ❌ `_page` - Screen entry points (follow [Page Rules](page.md))

---

## Table of Contents

1. [Component Responsibilities](#component-responsibilities)
2. [Core Design Rules](#core-design-rules)
3. [API Restrictions](#api-restrictions)
4. [Widget Misuse Rules](#widget-misuse-rules)
5. [Component Validation Checklist](#component-validation-checklist)

---

## Component Responsibilities

### What a Component SHOULD Define

- ✅ Visual style (colors, borders, shadows)
- ✅ Internal padding
- ✅ Icon + text arrangement
- ✅ Hover/focus/pressed states
- ✅ Loading state
- ✅ Disabled state
- ✅ Typography
- ✅ Internal spacing (padding, icon-text gaps)
- ✅ Border radius
- ✅ Min tap area
- ✅ Hover styles
- ✅ Internal alignment (of its own children)

### What a Component MUST NOT Define

- ❌ Width
- ❌ Height
- ❌ Max-width
- ❌ Column span
- ❌ Whether it is full-width
- ❌ Whether it is centered
- ❌ External margins
- ❌ Gaps between components
- ❌ Grid placement
- ❌ Screen-specific sizes

---

## Core Design Rules

### Rule 1: Components Must Be Size-Agnostic

A component must **never** decide:
- Its width
- Its height
- Its max-width
- Its column span
- Its screen-specific size

**❌ Wrong:**
```dart
// Inside a button component
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // ❌ Component deciding its own width
      child: ElevatedButton(...)
    );
  }
}
```

**✅ Correct:**
```dart
// The layout wraps the button
SizedBox(
  width: 200, // ✅ Layout decides the width
  child: MyButton()
)
```

---

### Rule 2: Components Must Expand to Their Parent

A component should naturally adapt to the space given by its parent container.

Flutter naturally supports this with:
- **Layout widgets**: `Row`, `Column`, `Expanded`, `Flexible`
- **Content widgets**: `Button`, `Card`, `Input`

Follow this separation.

**What components MUST do:**
- Accept constraints gracefully
- Wrap content naturally
- Not overflow horizontally by default
- Not assume infinite height
- Not assume infinite width

---

### Rule 3: Components Must Not Know About Breakpoints

A component should not know about:
- Mobile
- Tablet
- Desktop
- Web

**❌ Wrong:**
```dart
// Inside a component
if (MediaQuery.of(context).size.width < 600) {
  return MobileVersion();
}
```

**✅ Correct:**
Breakpoints belong to layout, not components.

---

### Rule 4: Components Control Internal Spacing Only

**What components MAY control:**
- ✔ Internal padding
- ✔ Icon-text spacing
- ✔ Border radius
- ✔ Typography
- ✔ Min tap area
- ✔ Hover styles

**What components MUST NOT control:**
- ❌ External margins
- ❌ Gaps between components
- ❌ Grid placement

---

### Rule 5: Components Must Be Container-Neutral

A component must work inside any container:
- `ListView`
- `GridView`
- `Row`
- `Column`
- `Wrap`
- `Sliver` widgets

> If it only works in one place, it's broken.

---

### Rule 6: Components Must Not Reposition Themselves

No internal alignment logic based on context.

**❌ Wrong:**
```dart
// Inside a component
final isMobile = MediaQuery.of(context).size.width < 600;
return Align(
  alignment: isMobile ? Alignment.center : Alignment.centerLeft,
  child: content,
);
```

**✅ Correct:**
That is layout logic, not component logic.

---

### Rule 7: Variants Are Allowed, Context Logic Is Not

**✅ Allowed Variants:**
- `PrimaryButton`
- `SecondaryButton`
- `DestructiveButton`
- `IconButton`

**❌ NOT Allowed:**
- `MobileButton`
- `DesktopButton`
- `WideButton`
- `FullWidthButton` (this is layout)

---

### Rule 8: Components Must Be Dumb About Their Surroundings

**Components must NOT care about:**
- What's next to them
- How many columns exist
- Where they appear on the page
- Whether they're in a list, grid, or sidebar

**Components SHOULD only care about:**
- Rendering themselves
- Handling interaction
- Visual feedback

> If a component asks "Am I in a modal?" or "Am I in a grid?", it's no longer reusable.

---

### Rule 9: One Component = One Responsibility

A component must not:
- Layout siblings
- Control page flow
- Change navigation
- Inspect siblings

---

### Rule 10: Components Should Be Happy Inside Any Box

> **Mantra**: "If I put this component in a 120px wide box or a 600px wide box, it should not break."

---

### Rule 11: Components Must Degrade Gracefully

**If space is too small:**
- Text wraps
- Content stacks
- Icons shrink
- Spacing compresses

**If space is too big:**
- Content doesn't look empty
- Line length stays readable
- Visual grouping remains

---

### Rule 12: Component Scaling Rules

You should define how components scale:
- How buttons scale
- How text scales
- How spacing scales
- How cards scale

> Not everything should just stretch.

Use `IntrinsicHeight`/`IntrinsicWidth` sparingly - they're expensive.

---

### Rule 13: The System Must Allow Change

If changing layout requires editing 40 components, your system is broken.

**A correct system lets you:**
- Swap layouts
- Change grid counts
- Adjust spacing
- Add breakpoints

…without touching components.

---

### Rule 14: Components Are Dumb, Layouts Are Smart

**Component's job:**
- Render content
- Handle states
- Manage interactions

**Layout's job:**
- Position components
- Define spacing
- Handle responsiveness

---

## API Restrictions

### Prohibited APIs Inside Components

Components must **NOT** use these APIs internally:

| API | Why It's Prohibited |
|-----|---------------------|
| `MediaQuery.of(context).size` | Makes component screen-aware |
| `LayoutBuilder` | Makes component context-aware |
| `double.infinity` as width/height | Component deciding its own size |
| Hardcoded width/height | Component deciding its own size |
| `Expanded` (for self) | Component deciding layout behavior |
| `Flexible` (for self) | Component deciding layout behavior |
| Breakpoint utilities | Makes component screen-aware |

> **Exception**: `Expanded` and `Flexible` are allowed for **internal** layout of children, not for the component itself.

### Allowed Widget Usage

**✅ Components CAN use:**
- `Padding` (internal padding only)
- `Row`, `Column` (for internal layout)
- `Expanded`, `Flexible` (for children, not self)
- `Center` (if intrinsic to design)
- `Container` (without width/height constraints)
- `IntrinsicHeight`/`IntrinsicWidth` (use sparingly)

---

## Widget Misuse Rules

**Do NOT use these patterns inside components:**

1. ❌ `Expanded` wrapping the entire component
```dart
// Wrong
class MyComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // ❌ Component wrapping itself
      child: Container(...)
    );
  }
}
```

2. ❌ `SizedBox(width: double.infinity)` inside a component
3. ❌ `AspectRatio` without understanding constraints
4. ❌ `FittedBox` as a layout fix (hides real issues)
5. ❌ `OverflowBox` casually (breaks constraints)
6. ❌ `Positioned` for layout (use only in `Stack` for overlays)
7. ❌ `Stack` for layout (use only for overlays/z-index)
8. ❌ `SingleChildScrollView` inside components (causes nested scrolling)
9. ❌ Nested scrollables by accident
10. ❌ `ConstrainedBox` with hardcoded max widths

---

## Component Validation Checklist

Before marking a component as complete, ask:

### ✅ The Ultimate Test

> **"If I place this inside any random container, will it still behave correctly?"**

If **NO**, the component is flawed.

### ✅ Size Test

> **"Does this component work in a 120px box AND a 600px box without breaking?"**

If **NO**, the component is not size-agnostic.

### ✅ Reusability Test

> **"Can I use this component in a ListView, GridView, Row, Column, and Wrap without modifications?"**

If **NO**, the component is not container-neutral.

### ✅ Separation of Concerns Test

> **"Does this component only handle its own visuals and interactions?"**

If **NO**, the component has too many responsibilities.

### ✅ Dependency Test

> **"Does this component use MediaQuery, LayoutBuilder, or breakpoint logic?"**

If **YES**, the component is violating API restrictions.

---

## Quick Reference

### Separation of Concerns

| Concern | Who Decides |
|---------|-------------|
| Width, Height, Max-width | **Layout** |
| Column span, Grid placement | **Layout** |
| Breakpoint logic | **Layout** |
| External margins, Gaps | **Layout** |
| Alignment in page | **Layout** |
| Responsiveness | **Layout** |
| Visual style, States | **Component** |
| Internal padding, Spacing | **Component** |
| Typography, Border radius | **Component** |
| Hover/focus/pressed states | **Component** |
| Content rendering | **Component** |

### Component Authoring Checklist

- [ ] Component is size-agnostic
- [ ] Component does not define width/height
- [ ] Component does not define max-width
- [ ] Component does not use `MediaQuery` for sizing
- [ ] Component does not use `LayoutBuilder` for sizing
- [ ] Component does not know about breakpoints
- [ ] Component does not inspect parent layout
- [ ] Component does not reposition itself based on context
- [ ] Component works in any container
- [ ] Component degrades gracefully
- [ ] Component does not overflow by default
- [ ] Component does not assume infinite space
- [ ] Component only controls internal spacing
- [ ] Component only controls its own visuals
- [ ] Component has one clear responsibility

---

**Remember**: Components = Content. Layout = Structure. Never mix the two.
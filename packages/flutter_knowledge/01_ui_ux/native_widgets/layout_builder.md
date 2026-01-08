# LayoutBuilder — Practical Notes (Flutter)

## Purpose

LayoutBuilder answers one question:

> **What constraints did my parent give me at this point in the widget tree?**

Use it to make **layout decisions**, not styling tweaks.

---

## How Flutter Layout Works (Mental Model)

1. Parent passes **BoxConstraints** to child
2. Child picks a **size within constraints**
3. Parent positions the child

Most UI bugs happen when a widget **assumes size** without knowing constraints.

---

## What LayoutBuilder Gives You

Inside `builder(context, constraints)`:

* `minWidth`, `maxWidth`
* `minHeight`, `maxHeight`

These describe how **strict or flexible** the parent is.

### Interpreting Constraints

* `min = 0, max = X` → Parent is flexible
* `min > 0, max = X` → Minimum size enforced
* `min == max` → Tight / forced size
* `max = infinity` → Unbounded (danger zone)

---

## When to Use LayoutBuilder

### 1. Layout structure must change

Use when the **widget tree changes** based on space.

Examples:

* Row → Column
* Compact card → Detailed card
* Grid columns change

---

### 2. Inside flexible or ambiguous parents

Useful when inside:

* `Row`
* `Column`
* `Expanded` / `Flexible`
* `Padding`

These often produce unclear or loose constraints.

---

### 3. Detect tight vs loose constraints

You need to know if size is forced or optional.

Example checks:

* `minWidth == maxWidth` → forced width
* `minWidth == 0` → can collapse

---

## When NOT to Use LayoutBuilder

### ❌ Styling-only changes

Do NOT use it for:

* Padding
* Font size
* Colors

Use theme, constants, or `MediaQuery`.

---

### ❌ Top-level screen logic

At `Scaffold` or app root:

* Constraints ≈ screen size
* `MediaQuery` is simpler

---

### ❌ Unbounded parents

It does NOT fix:

* `SingleChildScrollView`
* Infinite height/width

`maxHeight` or `maxWidth` may be `infinity`.

---

### ❌ State or heavy logic

Never:

* Call `setState`
* Run expensive computation

LayoutBuilder can rebuild often.

---

## Golden Rule

> **Use LayoutBuilder only when layout structure depends on constraints.**

If structure changes → use it
If only numbers change → don’t

---

## Quick Checklist (Before Using)

* Do I need parent constraints?
* Will widget structure change?
* Am I inside a flexible parent?

If any answer is **no**, skip LayoutBuilder.

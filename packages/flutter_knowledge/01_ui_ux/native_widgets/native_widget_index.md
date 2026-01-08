# Native Widgets Index

A curated collection of Flutter's built-in widgets. This index focuses on specialized tools that solve specific architectural and layout problems more elegantly than generic wrappers.

---

## 1. [Layout Builder](./layout_builder.md)
**"The Responsive Decision Maker"**
*   **Purpose:** Exposes the parent's `BoxConstraints` to the child, allowing for logic-driven layout changes.
*   **Use When:** You need to change the widget **structure** based on available space (e.g., switching from Row to Column).
*   **Avoid When:** You only need to change styling (padding, font size) – use `MediaQuery` or responsive wrappers instead.

## 2. [Baseline](./baseline.md)
**"The Typographic Aligner"**
*   **Purpose:** Aligns children based on the alphabetic baseline of their text, rather than their bottom edge.
*   **Use When:** Displaying text of different font sizes side-by-side (e.g., "$50" where ' is small and '50' is large).
*   **Avoid When:** Standard center or bottom alignment suffices.

## 3. [Offstage](./offstage.md)
**"The Invisible State Keeper"**
*   **Purpose:** Keeps a widget active in the tree (state preserved) but completely skips layout and painting phases.
*   **Use When:** You need to hide a complex widget (like a form or video player) but must preserve its exact state (user input, playback position).
*   **Avoid When:** You just need to hide something simple – use `if` (remove from tree) or `Visibility` (if you just need it invisible but taking space).

## 4. [DecoratedBox](./decorated_box.md)
**"The Lightweight Painter"**
*   **Purpose:** Paints a decoration (background, border, image) before or after its child paints.
*   **Use When:** You need visual styling but don't need the padding, margin, or constraint behaviors of a heavy `Container`.
*   **Avoid When:** You need complex layout composition (padding + margin + alignment) – `Container` is fine there.

## 5. [PhysicalModel](./physical_model.md)
**"The Shadow Architect"**
*   **Purpose:** Simulates a physical layer by clipping content and casting a realistic shadow based on elevation.
*   **Use When:** Creating custom cards or floating elements that need to match Material Design's lighting and shadow physics.
*   **Avoid When:** You need a purely cosmetic shadow (e.g., a colored glow) – use standard `BoxShadow`.
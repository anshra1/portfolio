# 🪟 Overlays & Floating UI

## 💡 The Situation: The "Floating Breakup" Problem
When building custom tooltips, dropdowns, or contextual menus, a common mistake is manually calculating the position of the floating element using `localToGlobal()` and placing it in an `OverlayEntry`. 

**The Failure:**
As soon as the parent widget moves (e.g., inside a `ListView`, `SingleChildScrollView`, or a translation animation), the overlay stays fixed at the initial coordinates while the anchor widget moves away. This creates a "broken" UI experience where tooltips float in empty space.

## 🛠️ The Architectural Solution: Composited Transforms
Flutter provides a specialized "Tow Bar" system to solve this at the compositing layer. Instead of manual math, we use a physical link between the anchor and the follower.

### **Key Components:**
1.  **`LayerLink`**: The object that bridges the anchor and the overlay.
2.  **`CompositedTransformTarget`**: Wrapped around the widget you want to follow.
3.  **`CompositedTransformFollower`**: Wrapped around the content inside the `OverlayEntry`.

### **When to use this?**
*   Custom Dropdown menus.
*   Contextual tooltips that must survive scrolling.
*   Floating action buttons that anchor to specific list items.

---

## 📚 Deep Dives
*   **[Implementation Guide & Code Example](./anchored_overlays.md)**: Detailed step-by-step guide on how to implement the "Tow Bar" pattern.

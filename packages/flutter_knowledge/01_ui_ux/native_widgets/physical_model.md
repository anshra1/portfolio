# PhysicalModel — Practical Notes

## Purpose

PhysicalModel is about realistic physics simulation:
> **Clip this content to a shape, elevate it, and cast a realistic shadow based on that elevation.**

It is the engine behind Material Design's shadow system.

---

## The Difference from BoxShadow

*   **BoxShadow:** A visual painting instruction. "Paint a blurry black oval here." It doesn't affect clipping or hit-testing.
*   **PhysicalModel:** A 3D structural instruction. "This widget is hovering 8 pixels above the surface." The engine calculates the shadow based on simulated light.

---

## When to Use

### 1. Non-Rectangular Cards
When you need a custom shape (like a circle or rounded rect) that clips its content *and* casts a matching shadow.

### 2. Custom Elevation
When you want the exact shadow look of a Material Card/Button but on a custom widget.

```dart
PhysicalModel(
  color: Colors.white,
  elevation: 8,
  shadowColor: Colors.black,
  borderRadius: BorderRadius.circular(16),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Text("Real Shadow"),
  ),
)
```

---

## When NOT to Use

*   **Custom Shadow Art:** If you want a blue neon glow or a shadow that goes in a weird direction, use `BoxShadow`. `PhysicalModel` tries to be realistic.
*   **Simple Rectangles:** `Material` widget often handles this automatically.

---

## Golden Rule

> **PhysicalModel = Structure (Clipping + Elevation). BoxShadow = Paint (Visual Effect).**

# Offstage — Practical Notes

## Purpose

Offstage is a "stealth mode" wrapper:
> **Keep this widget alive and ready, but make it invisible and take up zero space.**

It builds the widget and maintains its state, but skips the layout and paint phases.

---

## How it Differs from Others

*   **vs `Opacity(0.0)`:** Opacity is invisible but **takes up space** and receives touches.
*   **vs `Visibility(visible: false)`:** Can be configured to maintain state/size, but `Offstage` is explicitly designed for "alive but gone".
*   **vs `if (condition)`:** Using an `if` removes the widget from the tree, **destroying its state**.

---

## When to Use

### 1. Preserving State
When you need to hide a complex form or a video player but don't want to lose user input or playback position when it reappears.

### 2. Preloading Content
Rendering a heavy widget "off-screen" so it's ready to appear instantly without a layout jump.

### 3. Measuring Dimensions
(Advanced) Used internally by layout algorithms to measure a child's size without showing it.

```dart
Column(
  children: [
    Switch(value: _show, onChanged: (v) => setState(() => _show = v)),
    
    // State is preserved even when hidden!
    Offstage(
      offstage: !_show,
      child: TextField(controller: _textController), 
    ),
  ],
)
```

---

## When NOT to Use

*   **Simple hiding:** If you don't need to preserve state, just use an `if` statement to remove it from the tree. It saves memory.
*   **Large Lists:** Keeping a massive list `Offstage` consumes significant memory.

---

## Golden Rule

> **Use Offstage to pause visibility without killing state.**

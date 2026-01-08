# Baseline — Practical Notes

## Purpose

Baseline answers one specific layout need:
> **Align this child so its text sits on a specific vertical line.**

It aligns contents based on the **typographic baseline** of text, rather than the top/bottom of a container.

---

## The Problem it Solves

When you put text of different sizes in a `Row`, `CrossAxisAlignment.center` or `bottom` often looks "off" because the letters don't sit on the same line.

*   `Padding` is a magic number hack.
*   `Baseline` is the precise solution.

---

## When to Use

### 1. Mixed Typography in Rows
Aligning a large number with a small currency symbol or unit.

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.baseline,
  textBaseline: TextBaseline.alphabetic,
  children: [
    Text('50', style: TextStyle(fontSize: 40)),
    Baseline(
      baseline: 30, // Distance from the top to the baseline
      baselineType: TextBaseline.alphabetic,
      child: Text('USD', style: TextStyle(fontSize: 14)),
    ),
  ],
)
```

### 2. Superscripts / Subscripts
Creating mathematical or scientific notations (e.g., x², H₂O) where precise vertical positioning relative to text is required.

---

## When NOT to Use

*   **Standard Vertical Alignment:** If `Center` or `Bottom` alignment works visually, prefer those standard `Row/Column` properties.
*   **Rich Text:** If you just need different styles in one sentence, `Text.rich` (or `RichText`) is vastly superior and handles baselines automatically.

---

## Golden Rule

> **Use Baseline when you need to align distinct widgets by their text content, not their box boundaries.**

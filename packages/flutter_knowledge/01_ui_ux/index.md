# 🎨 UI & UX Engineering

This domain covers everything the user sees and interacts with. Our goal is to create "App Store quality" interfaces that feel responsive and alive.

## 🎬 Animations
Standard Flutter animations can be boilerplate-heavy. We prioritize a declarative, extension-based approach.

**Primary Package:** [`flutter_animate: ^4.5.2`](https://pub.dev/packages/flutter_animate)

**Rule #1: Use `flutter_animate` for Declarative UI Motion**
*   **When to use:** For all standard UI transitions (fades, slides, shimmers), staggered list entries, and tactile button feedback.

**Rule #2: Use `animated_text_kit` for Specialized Text Effects**
*   **When to use:** For narrative-style text effects like Typewriter, Typer, Wavy, or Liquid Fill animations.
*   **Primary Package:** [`animated_text_kit: ^4.3.0`](https://pub.dev/packages/animated_text_kit)

**[Deep Dive: Animations Guide](./animations.md)** - Shorthand syntax, text effects, and pro tips.

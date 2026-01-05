# 🎨 UI & UX Engineering

This domain covers everything the user sees and interacts with. Our goal is to create "App Store quality" interfaces that feel responsive and alive.

## 🎬 Animations
Standard Flutter animations can be boilerplate-heavy. We prioritize a declarative, extension-based approach to keep the codebase clean and maintainable.

**Rule #1: Use `flutter_animate` for Declarative UI Motion**
*   **When to use:** For all standard UI transitions (fades, slides, shimmers), staggered list entries, and tactile button feedback.
*   **Why:** It eliminates 90% of animation boilerplate, manages its own `AnimationController` lifecycle (no memory leaks), and makes code 10x more readable.
*   **Constraint:** Only reach for manual `AnimationControllers` or `CustomPainter` if you are building a complex game-like engine or highly custom physics that cannot be modeled as a sequence of effects.
*   **[Deep Dive: Flutter Animate Guide](./animations.md)** - Shorthand syntax, sequencing, and pro tips.

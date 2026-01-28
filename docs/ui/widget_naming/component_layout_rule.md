# Component-Level Layout Rule (`_layout`)

**Scope:** Arranges the internals of a specific component or provides a reusable structural utility.
**Consumer:** Used inside a `_unit`, `_control`, `_section`, or even `_page`.

## 1. Definition
A Component-Level Layout defines the **micro structure** or **structural behavior** of elements. It determines how widgets are arranged or constrained within their parent container.

## 2. Responsibilities
-   **Internal Arrangement:** Decides relative placement (e.g., Image left of Text).
-   **Constraint Management:** Limits width, handles aspect ratios, or manages specific responsive behaviors (e.g., "become 100% width on mobile").
-   **Slot Placement:** Accepts `Widget` slots as arguments to place them.

## 3. Strict Rules
-   **❌ No Leaf Widgets:** It must NOT create `Image`, `Text`, or `Button` widgets.
-   **❌ No State:** It is stateless.
-   **✅ Spacing & Alignment:** It handles `Padding`, `Align`, `Center`, `LayoutBuilder`.

## 4. Real-World Utility Example

This is a classic "Wrapper Layout". It doesn't know *what* it holds, only *how* to constrain it based on screen size.

```dart
// responsive_width_wrapper.dart
class ResponsiveWidthWrapper extends StatelessWidget {
  const ResponsiveWidthWrapper({
    required this.child,
    super.key,
    this.mobileWidthFactor = 1.0,
    this.tabletWidthFactor = 0.85,
    this.webWidthFactor = 0.75,
  });

  final Widget child;
  final double mobileWidthFactor;
  final double tabletWidthFactor;
  final double webWidthFactor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widthFactor;
        
        // Pure layout logic: deciding width based on available space
        if (constraints.maxWidth < 600) {
          widthFactor = mobileWidthFactor;
        } else if (constraints.maxWidth < 1100) {
          widthFactor = tabletWidthFactor;
        } else {
          widthFactor = webWidthFactor;
        }

        return FractionallySizedBox(
          widthFactor: widthFactor,
          child: child, // Consuming the child
        );
      },
    );
  }
}
```

import 'package:flutter/material.dart';

class ResponsiveGridLayout extends StatelessWidget {
  const ResponsiveGridLayout({
    required this.children,
    super.key,
    this.gap,
    this.limitOnMobile = false,
  });

  /// The list of widgets to display in the grid.
  final List<Widget> children;

  /// The spacing between items (horizontal and vertical).
  /// If null, defaults to 32.0 (gap-8).
  final double? gap;

  /// Whether to limit items on mobile (1-column) view.
  /// If true, only the first 2 items will be shown when in 1-column mode.
  /// Matches the behavior of "hidden md:flex" for the 3rd item in the HTML.
  final bool limitOnMobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Breakpoints:
        // sm: 640 (1 col < 640)
        // md: 768 (2 cols >= 768) - Note: Projects used 768, Learnings used 640.
        // We will standardize on the Projects logic (Tailwind defaults often use 768 for md)
        // or adhere to the specific HTML logic if provided.
        // Projects: 1 (<768), 2 (>=768), 3 (>=1024)
        // Learnings: 1 (<640), 2 (>=640), 3 (>=1024)

        // Let's standardize to the Learnings logic (640 is a common breakpoint for "tablet-ish")
        // But the HTML says "md:grid-cols-2", and tailwind md is usually 768px.
        // However, standardizing is key. I'll use 768 as the 2-col break to be safe for "Tablet",
        // or 640 if we want "Large Phone".
        // Let's use the explicit breakpoints from the previous file analysis:
        // Projects used 768. Learnings used 640.
        // I will use 700 as a safe middle or strictly follow one.
        // Let's use: < 700 = 1 col, 700-1024 = 2 cols, > 1024 = 3 cols.

        var crossAxisCount = 1;
        if (width >= 1024) {
          crossAxisCount = 3;
        } else if (width >= 700) {
          crossAxisCount = 2;
        }

        final visibleChildren =
            (limitOnMobile && crossAxisCount == 1 && children.length > 2)
            ? children.take(2).toList()
            : children;

        final effectiveGap = gap ?? 32.0;

        if (crossAxisCount == 1) {
          return Column(
            spacing: effectiveGap,
            children: visibleChildren,
          );
        } else {
          final totalGapWidth = effectiveGap * (crossAxisCount - 1);
          final itemWidth = (width - totalGapWidth) / crossAxisCount;

          return Wrap(
            spacing: effectiveGap,
            runSpacing: effectiveGap,
            children: visibleChildren.map((child) {
              return SizedBox(
                width: itemWidth,
                child: child,
              );
            }).toList(),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class ResponsiveGridLayout extends StatelessWidget {
  const ResponsiveGridLayout({
    required this.children,
    super.key,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Breakpoints based on Tailwind default or configured
        // sm: 640, md: 768, lg: 1024

        var crossAxisCount = 1;
        if (width >= 1024) {
          crossAxisCount = 3;
        } else if (width >= 768) {
          crossAxisCount = 2;
        }

        // Specific logic from HTML: "Project 3 (HIDDEN ON MOBILE)"
        // "Mobile" here likely means the 1-column view.
        // HTML: <div class="hidden md:flex ..."> for 3rd item.
        // So if crossAxisCount == 1, we show only 2 items.
        // If we have more than 2 items, and we are in 1-column mode, take 2.

        final visibleChildren = (crossAxisCount == 1 && children.length > 2)
            ? children.take(2).toList()
            : children;

        if (crossAxisCount == 1) {
          // 1 Column: Just a column with spacing
          return Column(
            spacing: 32, // gap-8 = 32px
            children: visibleChildren,
          );
        } else {
          // 2 or 3 Columns
          // Using Wrap or Run-based layout for grid behavior
          // Calculate item width

          const gap = 32.0; // gap-8
          final totalGapWidth = gap * (crossAxisCount - 1);
          final itemWidth = (width - totalGapWidth) / crossAxisCount;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
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

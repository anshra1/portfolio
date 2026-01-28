import 'package:flutter/material.dart';

class ResponsiveGridLayout extends StatelessWidget {
  const ResponsiveGridLayout({
    required this.children,
    this.limitOnMobile = true,
    super.key,
  });

  final List<Widget> children;
  final bool limitOnMobile;

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
        } else if (width >= 600) {
          crossAxisCount = 2;
        }

        final visibleChildren =
            (limitOnMobile && crossAxisCount == 1 && children.length > 2)
            ? children.take(2).toList()
            : children;

        if (crossAxisCount == 1) {
          return Column(
            spacing: 32,
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

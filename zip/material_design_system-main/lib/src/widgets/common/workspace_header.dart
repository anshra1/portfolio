import 'package:flutter/material.dart';
import 'package:material_design_system/theme/md_theme.dart';

/// A simple, reusable header for workspace-style screens.
/// Displays a single centered title with appropriate spacing below.
class WorkspaceHeader extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;

  const WorkspaceHeader({super.key, required this.title, this.textStyle});

  @override
  Widget build(BuildContext context) {
    final md = MdTheme.of(context);
    return Column(
      children: [
        Text(
          title,
          style:
              textStyle ??
              md.typ
                  .getHeadlineSmall(context)
                  .copyWith(fontWeight: FontWeight.bold, color: md.sys.onSurface),
          textAlign: TextAlign.center,
        ),
        // Consistent bottom margin
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:material_design_system/material_design_system.dart';

enum IconPosition { left, right, none }

class PrimaryButtonWithIcon extends StatelessWidget {
  const PrimaryButtonWithIcon({
    required this.onPressed,
    required this.text,
    this.toolTipText = '',
    this.icon,
    this.iconPosition = IconPosition.none,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderRadius,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.size,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final Widget? icon;
  final IconPosition iconPosition;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsets padding;
  final String toolTipText;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final md = MdTheme.of(context);
    return Tooltip(
      message: toolTipText,
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: size != null ? size!.width : double.infinity,
          height: size != null ? size!.height : 36,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                backgroundColor ?? md.com.button.elevatedButtonBackgroundColor,
              ),
              foregroundColor: WidgetStateProperty.all(
                foregroundColor ?? md.com.button.elevatedButtonForegroundColor,
              ),
              elevation: WidgetStateProperty.all(elevation ?? md.elevation.level0),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? md.sha.cornerLarge),
                ),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPosition == IconPosition.left) ...[
                  icon ?? const SizedBox.shrink(),
                  SizedBox(width: md.space.small(context)),
                ],

                //
                if (iconPosition != IconPosition.none) const SizedBox.shrink(),
                //
                Text(
                  text,
                  style: (textStyle ?? md.com.button.textStyle).copyWith(
                    color: foregroundColor,
                  ),
                ),
                //
                if (iconPosition == IconPosition.right) ...[
                  SizedBox(width: md.space.small(context)),
                  icon ?? const SizedBox.shrink(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

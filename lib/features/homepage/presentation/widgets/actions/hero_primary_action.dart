import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';

class HeroPrimaryAction extends StatelessWidget {
  const HeroPrimaryAction({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.xl,
          vertical: context.spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radius.xl * 10),
        ),
        elevation: 8,
        shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View My Projects',
            style: context.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: context.spacing.sm),
          Icon(Icons.arrow_right_alt, size: context.sizes.iconSm),
        ],
      ),
    );
  }
}

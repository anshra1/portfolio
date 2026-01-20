import 'package:flutter/material.dart';

class PortfolioOutlineButton extends StatefulWidget {
  const PortfolioOutlineButton({
    required this.text,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  State<PortfolioOutlineButton> createState() => _PortfolioOutlineButtonState();
}

class _PortfolioOutlineButtonState extends State<PortfolioOutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: Material(
          color: Colors.transparent,
          shape: StadiumBorder(
            side: BorderSide(
              color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
            ),
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(999),
            hoverColor: isDark
                ? Colors.grey[700]!.withValues(alpha: 0.5)
                : Colors.grey[200]!.withValues(alpha: 0.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                    ),
                  ),
                  if (widget.icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      widget.icon,
                      size: 20,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

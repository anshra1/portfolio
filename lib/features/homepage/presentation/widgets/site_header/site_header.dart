import 'package:flutter/material.dart';

class SiteHeader extends StatelessWidget implements PreferredSizeWidget {
  const SiteHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerTheme.color ?? Colors.grey[200]!,
          ),
        ),
      ),
      child: ClipRect(
        // For backdrop blur effect if we add it later
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Text(
                'Flutter Dev',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // Mobile Menu Button (Visible on mobile/tablet)
              // In a real responsive app, we'd check constraints.
              // For now, assuming mobile layout usage or responsive check.
              IconButton(
                onPressed: () {
                  // TODO: Toggle mobile menu
                },
                icon: const Icon(Icons.menu),
              ),

              // TODO: Desktop Nav (Hidden on mobile)
            ],
          ),
        ),
      ),
    );
  }
}

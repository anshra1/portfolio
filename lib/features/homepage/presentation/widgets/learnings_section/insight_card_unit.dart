import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_context.dart';
import 'package:portfolio/features/homepage/presentation/models/insight_view_model.dart';

class InsightCardUnit extends StatefulWidget {
  const InsightCardUnit({
    required this.viewModel,
    required this.actionSlot,
    super.key,
  });

  final InsightViewModel viewModel;
  final Widget actionSlot;

  @override
  State<InsightCardUnit> createState() => _InsightCardUnitState();
}

class _InsightCardUnitState extends State<InsightCardUnit> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          // Content Container
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1F2937) : Colors.white,
              borderRadius: BorderRadius.circular(context.radius.lg),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Thumbnail with Hover Scale
                SizedBox(
                  height: 224, // Matched ProjectCardUnit height (h-56)
                  child: ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedScale(
                          scale: _isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          child: Image.network(
                            widget.viewModel.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: theme.colorScheme.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: context.sizes.iconLg,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Subtle gradient overlay on hover
                        AnimatedOpacity(
                          opacity: _isHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(context.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.viewModel.title,
                        style: context.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _isHovered
                              ? theme.primaryColor
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: context.spacing.xs),

                      // Metadata
                      Text(
                        '${widget.viewModel.date} • ${widget.viewModel.readTime}',
                        style: context.labelSmall.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: context.spacing.md),

                      // Tags
                      Wrap(
                        spacing: context.spacing.sm,
                        runSpacing: context.spacing.sm,
                        children: widget.viewModel.tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.spacing.md,
                              vertical: context.spacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer.withValues(
                                alpha: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              tag.toUpperCase(),
                              style: context.labelSmall.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                letterSpacing: 0.5,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: context.spacing.md),

                      // Description
                      Text(
                        widget.viewModel.description,
                        style: context.bodyMedium.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.spacing.lg),

                      // Action Slot
                      widget.actionSlot,
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Border Overlay
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.radius.lg),
                  border: Border.all(
                    color: _isHovered
                        ? theme.primaryColor.withValues(alpha: 0.5)
                        : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

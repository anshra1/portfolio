import 'package:core_ui_kit/core_ui_kit.dart'; // For KitButtons
import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/models/project_display_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCardUnit extends StatefulWidget {
  const ProjectCardUnit({
    required this.project,
    required this.onDownloadPressed,
    super.key,
  });
  final ProjectDisplayModel project;
  final VoidCallback onDownloadPressed;

  @override
  State<ProjectCardUnit> createState() => _ProjectCardUnitState();
}

class _ProjectCardUnitState extends State<ProjectCardUnit> {
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
          // Content Container (Background, Shadow, Content)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1F2937)
                  : Colors.white, // bg-gray-800 : bg-white
              borderRadius: BorderRadius.circular(16), // rounded-xl
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
                // Image Section
                SizedBox(
                  height: 224, // h-56 (56 * 4 = 224px)
                  child: ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image with Scale Animation
                        AnimatedScale(
                          scale: _isHovered ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          child: Image.network(
                            widget.project.imageUrl,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDark ? Colors.grey[900] : Colors.grey[200],
                                child: const Center(child: Icon(Icons.broken_image)),
                              );
                            },
                          ),
                        ),
                        // Gradient Overlay (Opacity Animation)
                        AnimatedOpacity(
                          opacity: _isHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.2),
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

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(24), // p-6
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.project.title,
                              style: context.titleLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _isHovered
                                    ? theme.primaryColor
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // mb-2 is small, but let's give space
                      // Description
                      Text(
                        widget.project.description,
                        style: context.bodyMedium.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16), // mb-4
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF374151)
                                  : const Color(0xFFF3F4F6), // bg-gray-700 : bg-gray-100
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tag.toUpperCase(),
                              style: context.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.grey[300] : Colors.grey[800],
                                letterSpacing: 0.5,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24), // Space before buttons (was Spacer)
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: KitPrimaryButton(
                              onPressed: widget.onDownloadPressed,
                              leading: const Icon(Icons.install_mobile, size: 18),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: KitButtonShape.rounded,
                              borderRadius: BorderRadius.circular(8),
                              child: const Text('Download App'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          KitOutlineButton(
                            onPressed: () async {
                              if (widget.project.onViewCode != null) {
                                await launchUrl(Uri.parse(widget.project.onViewCode!));
                              }
                            },
                            padding: const EdgeInsets.all(12),
                            shape: KitButtonShape.rounded,
                            borderRadius: BorderRadius.circular(8),
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            child: const Icon(Icons.code, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Border Overlay (Positioned on top to avoid clipping)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? theme.primaryColor.withValues(
                            alpha: 0.5,
                          ) // hover:border-primary/50
                        : (isDark
                              ? const Color(0xFF374151)
                              : const Color(
                                  0xFFF3F4F6,
                                )), // border-gray-700 : border-gray-100
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

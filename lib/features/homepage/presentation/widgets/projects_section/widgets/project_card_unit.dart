import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/features/homepage/presentation/models/project_display_model.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/widgets/hero_social_link_action.dart';

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

  void _onEnter(_) => setState(() => _isHovered = true);
  void _onExit(_) => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: Stack(
        children: [
          _CardBackground(
            isHovered: _isHovered,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProjectImage(
                  project: widget.project,
                  isHovered: _isHovered,
                ),
                _ProjectDetails(
                  project: widget.project,
                  onDownloadPressed: widget.onDownloadPressed,
                  isHovered: _isHovered,
                ),
              ],
            ),
          ),
          _AnimatedBorderOverlay(isHovered: _isHovered),
        ],
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  const _CardBackground({
    required this.isHovered,
    required this.child,
  });

  final bool isHovered;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (isHovered)
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
      child: child,
    );
  }
}

class _ProjectImage extends StatelessWidget {
  const _ProjectImage({
    required this.project,
    required this.isHovered,
  });

  final ProjectDisplayModel project;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 224,
      child: ClipRect(
        child: AnimatedScale(
          scale: isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: Image.network(
            project.imageUrl,
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
      ),
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails({
    required this.project,
    required this.onDownloadPressed,
    required this.isHovered,
  });

  final ProjectDisplayModel project;
  final VoidCallback onDownloadPressed;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            project.title,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: isHovered ? theme.primaryColor : theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Description
          SizedBox(
            height: 44,
            child: Text(
              project.description,
              style: context.bodyMedium.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[800],
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          SizedBox(
            height: 28,
            child: ClipRect(
              child: _ProjectTags(tags: project.tags),
            ),
          ),
          const SizedBox(height: 24),

          // Buttons
          _ProjectActions(
            onDownloadPressed: onDownloadPressed,
            viewCodeUrl: project.onViewCode,
          ),
        ],
      ),
    );
  }
}

class _ProjectTags extends StatelessWidget {
  const _ProjectTags({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6),
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
    );
  }
}

class _ProjectActions extends StatelessWidget {
  const _ProjectActions({
    required this.onDownloadPressed,
    this.viewCodeUrl,
  });

  final VoidCallback onDownloadPressed;
  final String? viewCodeUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: KitPrimaryButton(
            onPressed: onDownloadPressed,
            leading: const Icon(Icons.install_mobile, size: 18),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: KitButtonShape.rounded,
            borderRadius: BorderRadius.circular(8),
            child: const Text('Download App'),
          ),
        ),
        const SizedBox(width: 12),
        HeroSocialLinkAction(
          url: viewCodeUrl!,
          icon: FontAwesomeIcons.github,
          tooltipLabel: 'View Code',
          brandColor: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ],
    );
  }
}

class _AnimatedBorderOverlay extends StatelessWidget {
  const _AnimatedBorderOverlay({required this.isHovered});

  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? theme.primaryColor.withValues(alpha: 0.5)
                  : (isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6)),
            ),
          ),
        ),
      ),
    );
  }
}

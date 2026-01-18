import 'package:flutter/material.dart';
import 'package:portfolio/features/projects/presentation/view_models/project_vm.dart';

class ProjectCardUnit extends StatelessWidget {
  final ProjectVM data;
  final Widget primaryActionSlot;
  final Widget secondaryActionSlot;

  const ProjectCardUnit({
    super.key,
    required this.data,
    required this.primaryActionSlot,
    required this.secondaryActionSlot,
  });

  @override
  Widget build(BuildContext context) {
    // Using a Container with decoration to match the mockup's card style
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12), // rounded-xl approx
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          SizedBox(
            height: 224, // h-56 = 14rem * 16px = 224px
            width: double.infinity,
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                );
              },
            ),
          ),

          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0), // p-6
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          data.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Icon placeholder if needed, matching mockup "smartphone" icon
                      // We could add a slot for this icon if it varies by project
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: data.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Actions
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: primaryActionSlot),
                      const SizedBox(width: 12),
                      secondaryActionSlot,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

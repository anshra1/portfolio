import 'package:flutter/material.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerTheme.color ?? Colors.grey[200]!,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Looking for a Flutter Engineer?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "I'm currently open to new opportunities. Let's discuss how I can contribute scalable, high-performance code to your mobile engineering team.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // CTA Button
          OutlinedButton(
            onPressed: () {
              // TODO: Mailto link
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              side: BorderSide(color: Theme.of(context).primaryColor),
              foregroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Get In Touch'),
          ),

          const SizedBox(height: 32),

          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.code),
              ), // GitHub placeholder
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.work),
              ), // LinkedIn placeholder
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.article),
              ), // Medium placeholder
            ],
          ),

          const SizedBox(height: 32),

          Text(
            '© 2024 Flutter Developer Portfolio. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/responsive_text/responsive_text.dart';

class ResponsiveTextExample extends StatelessWidget {
  const ResponsiveTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Text Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resize the window to see the effect!',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'Comparison (Base Size 16)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Standard Text (16px)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  ResponsiveText(
                    'Responsive Text (16px -> Scaled)',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),

            _buildSection(
              title: 'Headlines',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText(
                    'Display Large (Base 32)',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ResponsiveText(
                    'Headline Medium (Base 24)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            _buildSection(
              title: 'Body Text',
              child: const ResponsiveText(
                'This is a long paragraph of responsive text. It will be readable on mobile (14px) and comfortable on a large desktop monitor (21px). The scaling happens automatically based on the screen width.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),

            _buildSection(
              title: 'Explicit Scale Info',
              child: Builder(
                builder: (context) {
                  final width = MediaQuery.sizeOf(context).width;
                  return Text('Current Width: ${width.toStringAsFixed(0)}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

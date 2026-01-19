import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Typography Verification App
// Run this file to verify context extensions and font scaling
// ---------------------------------------------------------------------------

void main() {
  runApp(const TypographyTestApp());
}

class TypographyTestApp extends StatelessWidget {
  const TypographyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. MUST wrap in ScreenSizeDetector for scaling to work
    return ScreenSizeDetector(
      child: MaterialApp(
        title: 'Typography Verification',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const TypographyHomePage(),
      ),
    );
  }
}

class TypographyHomePage extends StatelessWidget {
  const TypographyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Debug info
    final screenWidth = MediaQuery.sizeOf(context).width;
    final windowClass = ScreenSizeDetector.of(context);

    // Get current font sizes directly from context extensions
    final dL = context.displayLarge.fontSize?.toStringAsFixed(1) ?? '?';
    final dM = context.displayMedium.fontSize?.toStringAsFixed(1) ?? '?';
    final hL = context.headlineLarge.fontSize?.toStringAsFixed(1) ?? '?';
    final bL = context.bodyLarge.fontSize?.toStringAsFixed(1) ?? '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography & Scaling Test'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Tag('Width: ${screenWidth.toInt()}'),
                const SizedBox(width: 8),
                _Tag('Class: ${windowClass.name.toUpperCase()}'),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header('Scaling Verification'),
            const Text('Resize the window to see values change.'),
            const SizedBox(height: 16),

            _ValueRow('displayLarge', dL, 'Base: 57.0'),
            _ValueRow('displayMedium', dM, 'Base: 45.0'),
            _ValueRow('headlineLarge', hL, 'Base: 32.0'),
            _ValueRow('bodyLarge', bL, 'Base: 16.0'),

            const Divider(height: 48),

            const _Header('Context Extension Visuals'),
            Text('displayLarge', style: context.displayLarge),
            const SizedBox(height: 8),
            Text('displayMedium', style: context.displayMedium),
            const SizedBox(height: 8),
            Text('displaySmall', style: context.displaySmall),
            const SizedBox(height: 24),

            Text('headlineLarge', style: context.headlineLarge),
            const SizedBox(height: 8),
            Text('headlineMedium', style: context.headlineMedium),
            const SizedBox(height: 8),
            Text('headlineSmall', style: context.headlineSmall),
            const SizedBox(height: 24),

            Text('titleLarge', style: context.titleLarge),
            Text('titleMedium', style: context.titleMedium),
            Text('titleSmall', style: context.titleSmall),
            const SizedBox(height: 24),

            Text(
              'bodyLarge: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: context.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'bodyMedium: Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: context.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'bodySmall: Ut enim ad minim veniam, quis nostrud exercitation.',
              style: context.bodySmall,
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('labelLarge', style: context.labelLarge)),
                Chip(label: Text('labelMedium', style: context.labelMedium)),
                Chip(label: Text('labelSmall', style: context.labelSmall)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow(this.label, this.value, this.base);
  final String label;
  final String value;
  final String base;

  @override
  Widget build(BuildContext context) {
    final hasScaled = value != base.replaceAll('Base: ', '');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Text(
            '$value px',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: hasScaled ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            hasScaled ? '(Scaled!)' : base,
            style: TextStyle(
              fontSize: 12,
              color: hasScaled ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

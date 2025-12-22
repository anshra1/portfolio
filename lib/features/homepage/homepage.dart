import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive System Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWindowSizeInfo(context),
            const SizedBox(height: 32),
            _buildTypographyTest(context),
            const SizedBox(height: 32),
            _buildLayoutTest(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWindowSizeInfo(BuildContext context) {
    final windowClass = ScreenSizeDetector.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Window Class: ${windowClass.name.toUpperCase()}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Current Width: ${width.toStringAsFixed(1)}dp'),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyTest(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. Responsive Typography', style: textTheme.titleLarge),
        const Divider(),
        Text('Display Large', style: textTheme.displayLarge),
        Text('Headline Large', style: textTheme.headlineLarge),
        Text('Title Large', style: textTheme.titleLarge),
        Text('Body Large', style: textTheme.bodyLarge),
        const SizedBox(height: 8),
        const Text(
          'Notice how these sizes change when you resize the window!',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildLayoutTest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2. Component Layout (ResponsiveLayoutBuilder)', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Text(
          'This component adapts to its PARENT width using the reusable toolkit widget.',
          style: TextStyle(color: Colors.grey),
        ),
        const Divider(),
        ResponsiveLayoutBuilder(
          builder: (context, windowClass) {
            if (windowClass.isDesktop) {
              return _buildDesktopLayout();
            } else if (windowClass.isTablet) {
              return _buildTabletLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      height: 100,
      color: Colors.blue.withOpacity(0.2),
      child: const Center(
        child: Text('💻 Desktop Layout (3-Column Grid or Sidebar Context)'),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Container(
      height: 100,
      color: Colors.green.withOpacity(0.2),
      child: const Center(
        child: Text('📱 Tablet Layout (2-Column Grid)'),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      height: 100,
      color: Colors.orange.withOpacity(0.2),
      child: const Center(
        child: Text('📱 Mobile Layout (Single Column)'),
      ),
    );
  }
}
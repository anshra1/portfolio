import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  // Define your brand seed colors with blue as primary
  final seeds = const ReferenceTokens(
    primary: Color(0xFF1976D2), // Blue primary
    secondary: Color(0xFF625B71),
    tertiary: Color(0xFF7D5260),
    neutral: Color(0xFF5E5E5E),
    neutralVariant: Color(0xFF5E6366),
    error: Color(0xFFBA1A1A),
    success: Color(0xFF146B3A),
    warning: Color(0xFFF7931A),
    info: Color(0xFF0077B6),
  );

  // Generate light and dark themes from seeds
  late final SystemTokens lightTheme = const StandardLightThemeGenerator().generate(
    seeds: seeds,
  );
  late final SystemTokens darkTheme = const StandardDarkThemeGenerator().generate(
    seeds: seeds,
  );

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveTypographyProvider(
      tokens: ResponsiveTokens.m3(),
      child: MaterialApp(
        title: 'Theme Generator Demo',
        themeMode: _themeMode,
        // Using SystemTokensConverter for clean theme creation
        theme: SystemTokensConverter.toThemeData(
          lightTheme,
          brightness: Brightness.light,
        ),
        darkTheme: SystemTokensConverter.toThemeData(
          darkTheme,
          brightness: Brightness.dark,
        ),
        home: ThemeDemoPage(
          onToggleTheme: _toggleTheme,
          isDarkMode: _themeMode == ThemeMode.dark,
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}

class ThemeDemoPage extends StatelessWidget {
  const ThemeDemoPage({
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.lightTheme,
    required this.darkTheme,
    super.key,
  });

  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final SystemTokens lightTheme;
  final SystemTokens darkTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = isDarkMode ? darkTheme : lightTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Generator Demo'),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Theme: ${isDarkMode ? "Dark" : "Light"}',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildColorSection('Primary Colors', [
              _ColorItem('Primary', colors.primary),
              _ColorItem('On Primary', colors.onPrimary),
              _ColorItem('Primary Container', colors.primaryContainer),
              _ColorItem('On Primary Container', colors.onPrimaryContainer),
            ]),
            _buildColorSection('Secondary Colors', [
              _ColorItem('Secondary', colors.secondary),
              _ColorItem('On Secondary', colors.onSecondary),
              _ColorItem('Secondary Container', colors.secondaryContainer),
              _ColorItem('On Secondary Container', colors.onSecondaryContainer),
            ]),
            _buildColorSection('Surface Colors', [
              _ColorItem('Surface', colors.surface),
              _ColorItem('On Surface', colors.onSurface),
              _ColorItem('Surface Container', colors.surfaceContainer),
              _ColorItem('Outline', colors.outline),
            ]),
            _buildColorSection('Extended Colors', [
              _ColorItem('Success', colors.success),
              _ColorItem('Warning', colors.warning),
              _ColorItem('Info', colors.info),
              _ColorItem('Error', colors.error),
            ]),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Title', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'This card uses the generated theme colors.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Responsive System',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _ResponsiveDemo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onToggleTheme,
        child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      ),
    );
  }

  Widget _buildColorSection(String title, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map(_buildColorTile).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildColorTile(_ColorItem item) {
    final brightness = ThemeData.estimateBrightnessForColor(item.color);
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          item.name,
          style: TextStyle(color: textColor, fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ColorItem {
  _ColorItem(this.name, this.color);
  final String name;
  final Color color;
}

class _ResponsiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Responsive Value Example: Different padding based on screen size
    final responsivePadding = const ResponsiveValue<EdgeInsets>(
      compact: EdgeInsets.all(16), // Mobile standard
      medium: EdgeInsets.all(24), // Tablet comfortable
      expanded: EdgeInsets.all(32), // Desktop spacious
    ).resolve(context);

    // 2. Responsive Text Style Example: Auto-scaling text
    // Using the pre-defined M3 responsive tokens
    final responsiveTitleStyle = context.responsiveTypography.headlineMedium
        .resolve(context)
        .copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    return Container(
      width: double.infinity,
      padding: responsivePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resize window to see changes!',
            style: responsiveTitleStyle,
          ),
          const SizedBox(height: 16),
          Text(
            'Current Window Class: ${ScreenSizeDetector.of(context).name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Padding: ${responsivePadding.left}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'The blue text above uses ResponsiveTextStyle to scale automatically or change properties completely on larger screens.',
          ),
        ],
      ),
    );
  }
}

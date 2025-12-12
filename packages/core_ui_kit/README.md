# Theme Generator

A Material 3 theme generator for Flutter that converts 9 seed colors into a complete 45+ semantic color palette using Material Color Utilities.

## Features

- 🎨 **9 Seed Colors** → **45+ Semantic Colors**
- 🌗 **Light & Dark Theme** generation
- 🔄 **ColorScheme Converter** - one-line theme creation
- 📦 **Zero configuration** - just provide your brand colors
- 🔧 **Material 3 compliant** tonal palettes

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  core_ui_kit:
    path: packages/core_ui_kit
```

## Quick Start

```dart
import 'package:core_ui_kit/core_ui_kit.dart';

// 1. Define your brand seed colors
final seeds = ReferenceTokens(
  primary: Color(0xFF1976D2),    // Blue
  secondary: Color(0xFF625B71),
  tertiary: Color(0xFF7D5260),
  neutral: Color(0xFF5E5E5E),
  neutralVariant: Color(0xFF5E6366),
  error: Color(0xFFBA1A1A),
  success: Color(0xFF146B3A),
  warning: Color(0xFFF7931A),
  info: Color(0xFF0077B6),
);

// 2. Generate themes
final lightTheme = StandardLightThemeGenerator().generate(seeds: seeds);
final darkTheme = StandardDarkThemeGenerator().generate(seeds: seeds);

// 3. Use with SystemTokensConverter (recommended)
MaterialApp(
  theme: SystemTokensConverter.toThemeData(
    lightTheme,
    brightness: Brightness.light,
  ),
  darkTheme: SystemTokensConverter.toThemeData(
    darkTheme,
    brightness: Brightness.dark,
  ),
);
```

## Files

| File | Purpose |
|------|---------|
| `reference_tokens.dart` | 9 seed colors (input) |
| `system_tokens.dart` | 45+ semantic colors (output) |
| `theme_generator.dart` | Abstract interface |
| `standard_light_theme_generator.dart` | Light theme generation |
| `standard_dark_theme_generator.dart` | Dark theme generation |
| `system_tokens_converter.dart` | Converts SystemTokens → ColorScheme/ThemeData |

## SystemTokensConverter

The converter provides two methods:

```dart
// Convert to ColorScheme only
ColorScheme colorScheme = SystemTokensConverter.toColorScheme(
  tokens, 
  Brightness.light,
);

// Convert to complete ThemeData
ThemeData theme = SystemTokensConverter.toThemeData(
  tokens,
  brightness: Brightness.light,
  useMaterial3: true,
);
```

## Generated Colors

### Primary/Secondary/Tertiary
- `primary`, `onPrimary`, `primaryContainer`, `onPrimaryContainer`
- Same pattern for secondary and tertiary

### Surface
- `surface`, `onSurface`, `surfaceVariant`, `onSurfaceVariant`
- `surfaceContainer`, `surfaceContainerLow`, `surfaceContainerHigh`, `surfaceContainerHighest`
- `inverseSurface`, `inverseOnSurface`

### Extended (not in ColorScheme)
- `success`, `onSuccess`, `successContainer`, `onSuccessContainer`
- `warning`, `onWarning`, `warningContainer`, `onWarningContainer`
- `info`, `onInfo`, `infoContainer`, `onInfoContainer`

## License

MIT

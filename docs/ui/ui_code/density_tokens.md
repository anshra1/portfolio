# Density Token System

A Flutter-native density system that adapts UI spacing, radius, and sizes based on platform (mobile vs desktop).

## Quick Start

```dart
import 'package:portfolio/core/theme/density/density.dart';

// Already configured in AppTheme - just use in widgets:
Container(
  padding: EdgeInsets.all(context.spacing.md),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.radius.lg),
  ),
  child: Icon(Icons.star, size: context.sizes.iconMd),
)
```

---

## How It Works

### Two-Layer Architecture

| Layer | What It Handles |
|-------|-----------------|
| **Flutter's VisualDensity** | Material widgets (buttons, text fields, list tiles) |
| **Our Custom Tokens** | Custom widgets (spacing, radius, sizes) |

Both are synced to the same platform detection — no conflicts.

---

## Available Tokens

### Spacing (`context.spacing`)

| Token | Mobile (Comfortable) | Desktop (Compact) |
|-------|---------------------|-------------------|
| `.xs` | 4px | 2px |
| `.sm` | 8px | 4px |
| `.md` | 16px | 8px |
| `.lg` | 24px | 16px |
| `.xl` | 32px | 24px |
| `.xxl` | 48px | 32px |

### Radius (`context.radius`)

| Token | Mobile | Desktop |
|-------|--------|---------|
| `.sm` | 8px | 4px |
| `.md` | 12px | 8px |
| `.lg` | 16px | 12px |
| `.xl` | 24px | 16px |

### Sizes (`context.sizes`)

| Token | Mobile | Desktop |
|-------|--------|---------|
| `.iconSm` | 20px | 16px |
| `.iconMd` | 24px | 20px |
| `.iconLg` | 32px | 24px |
| `.avatarSm` | 40px | 32px |
| `.avatarMd` | 56px | 40px |
| `.avatarLg` | 72px | 56px |

---

## Density Mode Detection

```dart
// Check current mode
if (context.isCompactDensity) {
  // Desktop-specific logic
}

// Get mode directly
final mode = context.densityMode; // DensityMode.comfortable or .compact
```

---

## Files

```
lib/core/theme/density/
├── density.dart            # Barrel export
├── density_mode.dart       # Enum + platform detection
├── density_spacing.dart    # Spacing tokens
├── density_radius.dart     # Radius tokens
├── density_sizes.dart      # Size tokens
├── app_density_tokens.dart # ThemeExtension
└── density_extensions.dart # BuildContext extensions
```

---

## Integration

Already configured in `app_theme.dart`:

```dart
ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  extensions: [AppDensityTokens.adaptive(defaultTargetPlatform)],
)
```

No additional setup required.

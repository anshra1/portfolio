# Adaptive Density Token System

## Overview

This document defines a **Density Token System** for custom widgets that integrates with Flutter's built-in `VisualDensity`. Flutter already handles Material widget density automatically—we only build tokens for **spacing**, **radius**, and **sizes** that Flutter doesn't manage.

> [!IMPORTANT]
> This system **complements** Flutter's `VisualDensity`, not replaces it. Material widgets (buttons, text fields, list tiles) auto-adjust via Flutter. Our tokens handle custom components.

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    APPLICATION                          │
├─────────────────────────────────────────────────────────┤
│  LAYER 2: Custom Density Tokens (what we build)         │
│  ├── DensitySpacing (padding, margins, gaps)            │
│  ├── DensityRadius (border corners)                     │
│  └── DensitySizes (icons, avatars, component heights)   │
├─────────────────────────────────────────────────────────┤
│  LAYER 1: Flutter's VisualDensity (use directly)        │
│  └── Material widgets auto-adjust internally            │
├─────────────────────────────────────────────────────────┤
│  SHARED: DensityMode (synced with Flutter's density)    │
└─────────────────────────────────────────────────────────┘
```

---

## What Flutter Handles (Don't Build)

| Component | Auto-Adjusted Property |
|-----------|----------------------|
| `ElevatedButton`, `TextButton` | Internal padding, min size |
| `TextField`, `TextFormField` | Content padding, height |
| `ListTile` | Vertical spacing |
| `Chip`, `FilterChip` | Height, padding |
| `AppBar` | Toolbar size, action spacing |
| `NavigationBar`, `NavigationRail` | Icon spacing, label position |

**Configuration (one line):**
```dart
ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
)
```

---

## What We Build (Custom Tokens)

### Scope

| Token Type | Purpose | Example Usage |
|------------|---------|---------------|
| **Spacing** | Padding, margins, gaps | Custom cards, sections, grids |
| **Radius** | Border corners | Card corners, containers |
| **Sizes** | Icons, avatars, heights | Custom icons, profile images |

### Density Modes

| Mode | Platform | Characteristics |
|------|----------|-----------------|
| **Comfortable** | Mobile/Touch | Larger spacing, generous touch targets |
| **Compact** | Desktop/Web | Tighter spacing, mouse-precision optimized |

---

## Token Specifications

### Spacing Tokens

| Token | Comfortable | Compact | Usage |
|-------|-------------|---------|-------|
| `xs` | 4px | 2px | Tight gaps |
| `sm` | 8px | 4px | Small padding |
| `md` | 16px | 8px | Standard padding |
| `lg` | 24px | 16px | Section spacing |
| `xl` | 32px | 24px | Large gaps |
| `xxl` | 48px | 32px | Major sections |

### Radius Tokens

| Token | Comfortable | Compact | Usage |
|-------|-------------|---------|-------|
| `sm` | 8px | 4px | Subtle rounding |
| `md` | 12px | 8px | Standard corners |
| `lg` | 16px | 12px | Cards, containers |
| `xl` | 24px | 16px | Hero elements |

### Size Tokens

| Token | Comfortable | Compact | Usage |
|-------|-------------|---------|-------|
| `iconSm` | 20px | 16px | Secondary icons |
| `iconMd` | 24px | 20px | Standard icons |
| `iconLg` | 32px | 24px | Primary icons |
| `avatarSm` | 40px | 32px | Small profiles |
| `avatarMd` | 56px | 40px | Standard profiles |
| `avatarLg` | 72px | 56px | Large profiles |

---

## File Structure

```
packages/core_ui_kit/lib/src/foundation/density/
├── density_mode.dart           # Enum + Flutter integration
├── density_spacing.dart        # Spacing values class
├── density_radius.dart         # Radius values class
├── density_sizes.dart          # Size values class
├── app_density_tokens.dart     # ThemeExtension wrapper
└── density_extensions.dart     # BuildContext extensions
```

---

## Implementation Plan

### Phase 1: Core System

#### 1.1 Create `density_mode.dart`
```dart
enum DensityMode { comfortable, compact }

DensityMode getDensityFromContext(BuildContext context) {
  final visualDensity = Theme.of(context).visualDensity;
  return visualDensity.vertical < 0 
      ? DensityMode.compact 
      : DensityMode.comfortable;
}
```

#### 1.2 Create `density_spacing.dart`
```dart
class DensitySpacing {
  final double xs, sm, md, lg, xl, xxl;
  
  const DensitySpacing.comfortable()
      : xs = 4, sm = 8, md = 16, lg = 24, xl = 32, xxl = 48;
  
  const DensitySpacing.compact()
      : xs = 2, sm = 4, md = 8, lg = 16, xl = 24, xxl = 32;
}
```

#### 1.3 Create `density_radius.dart`
```dart
class DensityRadius {
  final double sm, md, lg, xl;
  
  const DensityRadius.comfortable()
      : sm = 8, md = 12, lg = 16, xl = 24;
  
  const DensityRadius.compact()
      : sm = 4, md = 8, lg = 12, xl = 16;
}
```

#### 1.4 Create `density_sizes.dart`
```dart
class DensitySizes {
  final double iconSm, iconMd, iconLg;
  final double avatarSm, avatarMd, avatarLg;
  
  const DensitySizes.comfortable()
      : iconSm = 20, iconMd = 24, iconLg = 32,
        avatarSm = 40, avatarMd = 56, avatarLg = 72;
  
  const DensitySizes.compact()
      : iconSm = 16, iconMd = 20, iconLg = 24,
        avatarSm = 32, avatarMd = 40, avatarLg = 56;
}
```

---

### Phase 2: ThemeExtension Integration

#### 2.1 Create `app_density_tokens.dart`
```dart
class AppDensityTokens extends ThemeExtension<AppDensityTokens> {
  final DensityMode mode;
  final DensitySpacing spacing;
  final DensityRadius radius;
  final DensitySizes sizes;

  const AppDensityTokens({
    required this.mode,
    required this.spacing,
    required this.radius,
    required this.sizes,
  });

  factory AppDensityTokens.comfortable() => AppDensityTokens(
    mode: DensityMode.comfortable,
    spacing: const DensitySpacing.comfortable(),
    radius: const DensityRadius.comfortable(),
    sizes: const DensitySizes.comfortable(),
  );

  factory AppDensityTokens.compact() => AppDensityTokens(
    mode: DensityMode.compact,
    spacing: const DensitySpacing.compact(),
    radius: const DensityRadius.compact(),
    sizes: const DensitySizes.compact(),
  );

  @override
  ThemeExtension<AppDensityTokens> copyWith({...}) { ... }

  @override
  ThemeExtension<AppDensityTokens> lerp(other, t) { ... }
}
```

---

### Phase 3: Developer Experience

#### 3.1 Create `density_extensions.dart`
```dart
extension DensityExtensions on BuildContext {
  AppDensityTokens get density =>
      Theme.of(this).extension<AppDensityTokens>()!;

  DensitySpacing get spacing => density.spacing;
  DensityRadius get radius => density.radius;
  DensitySizes get sizes => density.sizes;
  DensityMode get densityMode => density.mode;
}
```

---

### Phase 4: App Integration

#### 4.1 Configure in `MaterialApp`
```dart
MaterialApp(
  theme: ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [
      // Sync with platform density
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android
          ? AppDensityTokens.comfortable()
          : AppDensityTokens.compact(),
    ],
  ),
)
```

---

## Usage Examples

### Custom Card with Density-Aware Tokens
```dart
Container(
  padding: EdgeInsets.all(context.spacing.md),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.radius.lg),
    color: Colors.white,
  ),
  child: Row(
    children: [
      CircleAvatar(radius: context.sizes.avatarMd / 2),
      SizedBox(width: context.spacing.sm),
      Icon(Icons.star, size: context.sizes.iconMd),
    ],
  ),
)
```

### Mixed: Material + Custom
```dart
Column(
  children: [
    // Flutter handles this automatically
    ElevatedButton(onPressed: () {}, child: Text('Submit')),
    
    SizedBox(height: context.spacing.lg), // Our token
    
    // Our custom component uses our tokens
    ProjectCard(padding: context.spacing.md),
  ],
)
```

---

## Migration Strategy

### From Static `KitSpacing`
```dart
// Before
Container(padding: EdgeInsets.all(KitSpacing.md))

// After
Container(padding: EdgeInsets.all(context.spacing.md))
```

### Coexistence Period
- Keep `KitSpacing` as fallback for non-widget contexts
- Gradually migrate widgets to `context.spacing`
- Remove `KitSpacing` after full migration

---

## Verification Checklist

- [ ] Platform detection works (mobile vs desktop)
- [ ] Material widgets auto-adjust with `VisualDensity`
- [ ] Custom tokens sync with Flutter's density
- [ ] Token values render correctly per mode
- [ ] No accessibility regressions (touch targets ≥40px)
- [ ] Smooth theme transitions if switching modes

---

## Dependencies

- **None** - Pure Dart/Flutter, no external packages
- Integrates with existing `ThemeData` system

---

**Status:** Ready for Implementation  
**Estimated Effort:** 4-6 hours  
**Files to Create:** 6  
**Breaking Changes:** None (additive system)

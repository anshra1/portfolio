# Density Tokens - AI Implementation Guide

> **Purpose**: This guide helps AI assistants correctly implement density-aware UI in this Flutter project.

---

## MANDATORY: Always Use Density Tokens

**NEVER use hardcoded pixel values** for spacing, padding, margins, border radius, or icon/avatar sizes.

### ❌ WRONG - Hardcoded Values
```dart
Container(
  padding: EdgeInsets.all(16),  // WRONG!
  margin: EdgeInsets.symmetric(horizontal: 24),  // WRONG!
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  // WRONG!
  ),
  child: Icon(Icons.star, size: 24),  // WRONG!
)
```

### ✅ CORRECT - Density Tokens
```dart
Container(
  padding: EdgeInsets.all(context.spacing.md),
  margin: EdgeInsets.symmetric(horizontal: context.spacing.lg),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.radius.md),
  ),
  child: Icon(Icons.star, size: context.sizes.iconMd),
)
```

---

## Required Import

```dart
import 'package:portfolio/core/theme/density/density.dart';
```

This single import provides all density extensions on `BuildContext`.

---

## Context Extensions Reference

### Spacing: `context.spacing`

Use for: **padding, margin, gaps, SizedBox dimensions**

| Token | Use Case |
|-------|----------|
| `context.spacing.xs` | Minimal gaps, icon-to-text spacing |
| `context.spacing.sm` | Small padding, list item internal spacing |
| `context.spacing.md` | **Default** padding, card content spacing |
| `context.spacing.lg` | Section spacing, card margins |
| `context.spacing.xl` | Large section gaps |
| `context.spacing.xxl` | Page-level spacing, major sections |

**Examples:**
```dart
// Padding
padding: EdgeInsets.all(context.spacing.md)
padding: EdgeInsets.symmetric(
  horizontal: context.spacing.lg,
  vertical: context.spacing.sm,
)

// Margins
margin: EdgeInsets.only(bottom: context.spacing.xl)

// Gaps in Row/Column
SizedBox(width: context.spacing.sm)
SizedBox(height: context.spacing.md)

// Gap widget (Flutter 3.x+)
Column(
  children: [
    Widget1(),
    Gap(context.spacing.md),  // If using gap package
    Widget2(),
  ],
)
```

---

### Radius: `context.radius`

Use for: **border radius, rounded corners**

| Token | Use Case |
|-------|----------|
| `context.radius.sm` | Chips, small badges, subtle rounding |
| `context.radius.md` | **Default** for buttons, text fields, cards |
| `context.radius.lg` | Large cards, modals, dialogs |
| `context.radius.xl` | Full-screen sheets, hero elements |

**Examples:**
```dart
// BoxDecoration
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(context.radius.md),
)

// ClipRRect
ClipRRect(
  borderRadius: BorderRadius.circular(context.radius.lg),
  child: Image(...),
)

// Individual corners
borderRadius: BorderRadius.only(
  topLeft: Radius.circular(context.radius.lg),
  topRight: Radius.circular(context.radius.lg),
)
```

---

### Sizes: `context.sizes`

Use for: **icons, avatars, fixed-size elements**

| Token | Use Case |
|-------|----------|
| `context.sizes.iconSm` | Secondary icons, inline icons |
| `context.sizes.iconMd` | **Default** icon size |
| `context.sizes.iconLg` | Prominent icons, empty states |
| `context.sizes.avatarSm` | Compact lists, inline mentions |
| `context.sizes.avatarMd` | **Default** avatar size |
| `context.sizes.avatarLg` | Profile headers, hero avatars |

**Examples:**
```dart
// Icons
Icon(Icons.star, size: context.sizes.iconMd)
Icon(Icons.arrow_forward, size: context.sizes.iconSm)

// Avatars
CircleAvatar(radius: context.sizes.avatarMd / 2)

// SizedBox for fixed dimensions
SizedBox(
  width: context.sizes.iconLg,
  height: context.sizes.iconLg,
  child: LoadingIndicator(),
)
```

---

## Density Mode Checks

When you need platform-specific logic beyond just different values:

```dart
// Boolean checks
if (context.isCompactDensity) {
  // Desktop-specific: show more columns, compact layout
}

if (context.isComfortableDensity) {
  // Mobile-specific: larger touch targets
}

// Enum access
switch (context.densityMode) {
  case DensityMode.comfortable:
    return MobileLayout();
  case DensityMode.compact:
    return DesktopLayout();
}
```

---

## Common Patterns

### Card with Proper Density
```dart
Container(
  padding: EdgeInsets.all(context.spacing.md),
  margin: EdgeInsets.symmetric(
    horizontal: context.spacing.lg,
    vertical: context.spacing.sm,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.radius.lg),
    color: Theme.of(context).colorScheme.surface,
  ),
  child: Row(
    children: [
      Icon(Icons.info, size: context.sizes.iconMd),
      SizedBox(width: context.spacing.sm),
      Expanded(child: Text('Card content')),
    ],
  ),
)
```

### List Item with Avatar
```dart
ListTile(
  contentPadding: EdgeInsets.symmetric(
    horizontal: context.spacing.lg,
    vertical: context.spacing.sm,
  ),
  leading: CircleAvatar(
    radius: context.sizes.avatarSm / 2,
    child: Icon(Icons.person, size: context.sizes.iconSm),
  ),
  title: Text('User Name'),
)
```

### Button Group with Gaps
```dart
Row(
  children: [
    ElevatedButton(onPressed: () {}, child: Text('Primary')),
    SizedBox(width: context.spacing.sm),
    OutlinedButton(onPressed: () {}, child: Text('Secondary')),
  ],
)
```

### Responsive Section Spacing
```dart
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.spacing.xl,
    vertical: context.spacing.xxl,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Section Title', style: Theme.of(context).textTheme.headlineMedium),
      SizedBox(height: context.spacing.lg),
      // Section content...
    ],
  ),
)
```

---

## Value Reference Table

### Spacing Values
| Token | Comfortable (Mobile) | Compact (Desktop) |
|-------|---------------------|-------------------|
| `xs` | 4 | 2 |
| `sm` | 8 | 4 |
| `md` | 16 | 8 |
| `lg` | 24 | 16 |
| `xl` | 32 | 24 |
| `xxl` | 48 | 32 |

### Radius Values
| Token | Comfortable | Compact |
|-------|-------------|---------|
| `sm` | 8 | 4 |
| `md` | 12 | 8 |
| `lg` | 16 | 12 |
| `xl` | 24 | 16 |

### Size Values
| Token | Comfortable | Compact |
|-------|-------------|---------|
| `iconSm` | 20 | 16 |
| `iconMd` | 24 | 20 |
| `iconLg` | 32 | 24 |
| `avatarSm` | 40 | 32 |
| `avatarMd` | 56 | 40 |
| `avatarLg` | 72 | 56 |

---

## Rules Summary

1. **Always import**: `package:portfolio/core/theme/density/density.dart`
2. **Never hardcode**: padding, margin, gaps, radius, icon sizes, avatar sizes
3. **Use context extensions**: `context.spacing`, `context.radius`, `context.sizes`
4. **Default tokens**: Use `.md` as the default size when unsure
5. **Semantic naming**: Choose token size based on semantic meaning (small detail vs. section gap)

# Typography System - AI Implementation Guide

> **Purpose**: This guide helps AI assistants correctly implement responsive typography in this Flutter project.

---

## MANDATORY: Use Context Extensions for Text Styling

**NEVER use hardcoded TextStyle** for standard text. Use the responsive typography system.

### ❌ WRONG - Hardcoded Styles
```dart
Text(
  'Welcome',
  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),  // WRONG!
)
```

### ✅ CORRECT - Context Extensions
```dart
Text(
  'Welcome',
  style: context.headlineLarge,  // Auto-scales based on screen
)
```

---

## Required Import

```dart
import 'package:portfolio/core/theme/typography/typography.dart';
```

This single import provides all typography extensions on `BuildContext`.

---

## Context Extensions Reference

### Display (Hero Text)

Use for: **Landing pages, hero sections, major announcements**

| Extension | Base Size | Desktop Size | Use Case |
|-----------|-----------|--------------|----------|
| `context.displayLarge` | 57px | ~80px | Hero banners, splash screens |
| `context.displayMedium` | 45px | ~63px | Feature highlights |
| `context.displaySmall` | 36px | ~50px | Prominent headings |

```dart
// Hero section
Text('Build Amazing Apps', style: context.displayLarge);

// Feature highlight
Text('New Features', style: context.displayMedium);
```

---

### Headline (Section Headers)

Use for: **Page titles, section headers, dialog titles**

| Extension | Base Size | Desktop Size | Use Case |
|-----------|-----------|--------------|----------|
| `context.headlineLarge` | 32px | ~41px | Page titles |
| `context.headlineMedium` | 28px | ~36px | Section headers |
| `context.headlineSmall` | 24px | ~31px | Card titles, subsections |

```dart
// Page title
Text('My Projects', style: context.headlineLarge);

// Section header
Text('Recent Work', style: context.headlineMedium);

// Card title
Text('Flutter App', style: context.headlineSmall);
```

---

### Title (Sub-headers)

Use for: **List headers, form sections, navigation items**

| Extension | Base Size | Desktop Size | Use Case |
|-----------|-----------|--------------|----------|
| `context.titleLarge` | 22px | ~26px | List headers, dialog subtitles |
| `context.titleMedium` | 16px | ~19px | Navigation items, form headers |
| `context.titleSmall` | 14px | ~17px | Tab labels, table headers |

```dart
// List header
Text('Team Members', style: context.titleLarge);

// Navigation item
Text('Settings', style: context.titleMedium);

// Tab label
Text('Overview', style: context.titleSmall);
```

---

### Body (Content Text)

Use for: **Article content, descriptions, paragraphs**

| Extension | Base Size | Desktop Size | Use Case |
|-----------|-----------|--------------|----------|
| `context.bodyLarge` | 16px | ~18px | Primary content, articles |
| `context.bodyMedium` | 14px | ~15px | Secondary content, descriptions |
| `context.bodySmall` | 12px | ~13px | Captions, helper text |

```dart
// Article content
Text(
  'This is the main content of the article...',
  style: context.bodyLarge,
);

// Description
Text('Last updated 2 hours ago', style: context.bodySmall);
```

---

### Label (UI Elements)

Use for: **Buttons, chips, badges** - No scaling for UI consistency

| Extension | Size | Use Case |
|-----------|------|----------|
| `context.labelLarge` | 14px | Primary buttons |
| `context.labelMedium` | 12px | Secondary buttons, chips |
| `context.labelSmall` | 11px | Badges, footnotes |

```dart
// Button text
ElevatedButton(
  onPressed: () {},
  child: Text('Submit', style: context.labelLarge),
);

// Chip
Chip(label: Text('Flutter', style: context.labelMedium));

// Badge
Text('NEW', style: context.labelSmall);
```

---

## Scaling Reference Table

### By Category

| Category | Compact | Medium | Expanded | Large | ExtraLarge |
|----------|---------|--------|----------|-------|------------|
| **Display** | 1.0x | 1.10x | 1.20x | 1.30x | 1.40x |
| **Headline** | 1.0x | 1.08x | 1.15x | 1.22x | 1.28x |
| **Title** | 1.0x | 1.05x | 1.10x | 1.15x | 1.18x |
| **Body** | 1.0x | 1.00x | 1.05x | 1.08x | 1.10x |
| **Label** | 1.0x | 1.00x | 1.00x | 1.00x | 1.00x |

### Why Different Scaling?

- **Display/Headline**: Scale aggressively - users are further from large screens
- **Body**: Scale conservatively - readability is paramount
- **Label**: No scaling - UI controls should stay consistent

---

## Common Patterns

### Page with Hero and Content
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Hero
    Text('Welcome Back', style: context.displaySmall),
    SizedBox(height: context.spacing.md),
    
    // Subtitle
    Text('Here\'s what happened', style: context.titleMedium),
    SizedBox(height: context.spacing.xl),
    
    // Section
    Text('Recent Activity', style: context.headlineSmall),
    SizedBox(height: context.spacing.md),
    
    // Content
    Text('Your project was updated...', style: context.bodyLarge),
  ],
)
```

### Card with Title and Description
```dart
Container(
  padding: EdgeInsets.all(context.spacing.md),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.radius.lg),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Project Name', style: context.headlineSmall),
      SizedBox(height: context.spacing.sm),
      Text('A brief description of the project...', style: context.bodyMedium),
      SizedBox(height: context.spacing.md),
      Text('Updated 2 days ago', style: context.bodySmall),
    ],
  ),
)
```

### List Item with Actions
```dart
ListTile(
  title: Text('Item Title', style: context.titleMedium),
  subtitle: Text('Supporting text', style: context.bodySmall),
  trailing: TextButton(
    onPressed: () {},
    child: Text('Action', style: context.labelLarge),
  ),
)
```

---

## Customizing Styles

When you need to modify a style (color, weight, etc.), use `.copyWith()`:

```dart
// Change color
Text(
  'Error Message',
  style: context.bodyMedium.copyWith(
    color: Theme.of(context).colorScheme.error,
  ),
);

// Change weight
Text(
  'Emphasized Text',
  style: context.bodyLarge.copyWith(
    fontWeight: FontWeight.w600,
  ),
);

// Multiple modifications
Text(
  'Special Text',
  style: context.headlineSmall.copyWith(
    color: Colors.blue,
    fontStyle: FontStyle.italic,
  ),
);
```

---

## Static Access (No Context)

When `BuildContext` is unavailable, use the full tokens:

```dart
// Get static base style
final tokens = ResponsiveTokens.m3();
final staticStyle = tokens.bodyLarge.value;  // Returns base (mobile) size
```

---

## Selection Guide

| Need | Use |
|------|-----|
| Landing page hero | `displayLarge` or `displayMedium` |
| Page title | `headlineLarge` |
| Section header | `headlineMedium` or `headlineSmall` |
| Card/dialog title | `headlineSmall` or `titleLarge` |
| List item title | `titleMedium` |
| Primary body text | `bodyLarge` |
| Secondary/supporting text | `bodyMedium` |
| Caption/timestamp | `bodySmall` |
| Primary button | `labelLarge` |
| Secondary button/chip | `labelMedium` |
| Badge/footnote | `labelSmall` |

---

## Rules Summary

1. **Always import**: `package:portfolio/core/theme/typography/typography.dart`
2. **Never hardcode**: font sizes in TextStyle
3. **Use context extensions**: `context.bodyLarge`, `context.headlineMedium`, etc.
4. **Combine with density**: Use `context.spacing` for gaps between text
5. **Customize via copyWith**: For color/weight changes, chain `.copyWith()`
6. **Semantic selection**: Choose style based on content purpose, not size

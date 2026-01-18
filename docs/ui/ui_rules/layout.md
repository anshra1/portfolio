# Layout Design Rules

> **Core Principle**: Layout controls space and structure. Components control content and visuals.

---

## Table of Contents

1. [Layout Responsibilities](#layout-responsibilities)
2. [Layout Architecture](#layout-architecture)
3. [Implementation Pattern](#implementation-pattern)
4. [Layout Design Principles](#layout-design-principles)
5. [Quick Reference](#quick-reference)

---

## Layout Responsibilities

### What a Layout SHOULD Define

- ✅ How wide a component is
- ✅ Whether it stretches
- ✅ Whether it is constrained
- ✅ How many items per row
- ✅ Alignment of components
- ✅ Spacing between components
- ✅ Vertical rhythm
- ✅ Section spacing
- ✅ Group spacing
- ✅ Content density
- ✅ Breathing room

### What a Layout MUST NOT Define

- ❌ Component internal styles
- ❌ Component states (hover, focus, etc.)
- ❌ Component typography
- ❌ Component internal padding
- ❌ Component visual appearance

---

## Layout Architecture

### High-Level Structure

Your application should follow this pattern:

```
Page
 └── LayoutSwitcher
       ├── MobileLayout
       ├── TabletLayout
       └── DesktopLayout
```

**Key principle**: All three layouts use the **same components**.

### Why This Matters

- **Separation of concerns**: Layout decides structure, components handle content
- **Reusability**: Same components work across all breakpoints
- **Maintainability**: Change layout without touching components
- **Testability**: Test components independently of layout

---

## Implementation Pattern

### Step 1: Define Breakpoint System

Define your breakpoints **once** in a centralized location:

```dart
// lib/core/responsive/breakpoints.dart

bool isMobile(double width) => width < 600;
bool isTablet(double width) => width >= 600 && width < 1024;
bool isDesktop(double width) => width >= 1024;

// Or use an enum-based approach
enum Breakpoint { mobile, tablet, desktop }

Breakpoint getBreakpoint(double width) {
  if (width < 600) return Breakpoint.mobile;
  if (width < 1024) return Breakpoint.tablet;
  return Breakpoint.desktop;
}
```

---

### Step 2: Create Layout Switcher

Build a reusable responsive layout switcher:

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) return mobile;
        if (width < 1024) return tablet;
        return desktop;
      },
    );
  }
}
```

**Optional**: Support tablet fallback to mobile or desktop:

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) return mobile;
        if (width < 1024) return tablet ?? mobile;
        return desktop;
      },
    );
  }
}
```

---

### Step 3: Use ResponsiveLayout in Pages

Your page delegates layout decisions to the layout switcher:

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: HomeMobileLayout(),
      tablet: HomeTabletLayout(),
      desktop: HomeDesktopLayout(),
    );
  }
}
```

---

### Step 4: Create Breakpoint-Specific Layouts

Each layout defines **structure only**, not content.

#### Mobile Layout

```dart
class HomeMobileLayout extends StatelessWidget {
  const HomeMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProjectCard(),
          SizedBox(height: 16),
          ProjectCard(),
          SizedBox(height: 16),
          ProjectCard(),
        ],
      ),
    );
  }
}
```

#### Tablet Layout

```dart
class HomeTabletLayout extends StatelessWidget {
  const HomeTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: EdgeInsets.all(16),
      children: [
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
      ],
    );
  }
}
```

#### Desktop Layout

```dart
class HomeDesktopLayout extends StatelessWidget {
  const HomeDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      padding: EdgeInsets.all(32),
      children: [
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
        ProjectCard(),
      ],
    );
  }
}
```

---

### Step 5: Keep Components Size-Neutral

Components must not know about their layout context:

```dart
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Title"),
          SizedBox(height: 8),
          Text("Description"),
          SizedBox(height: 16),
          MyButton(),
        ],
      ),
    );
  }
}
```

**Notice**:
- ❌ No width defined
- ❌ No breakpoint logic
- ❌ No layout decisions
- ✅ Only internal padding and styling

---

## Layout Design Principles

### Principle 1: Layout Controls Space, Not Components

Layout must control:
- ✔ Vertical rhythm
- ✔ Section spacing
- ✔ Group spacing
- ✔ Content density
- ✔ Breathing room

Components must not:
- ❌ Define external margins
- ❌ Control spacing to siblings
- ❌ Adjust density based on screen size

---

### Principle 2: Layout Should Be Declarative, Not Imperative

**❌ Bad mental model** (imperative):
> "If mobile then do this, else do that"

```dart
// Bad: Imperative layout
Widget build(BuildContext context) {
  if (isMobile(context)) {
    return Column(children: items);
  } else {
    return Row(children: items);
  }
}
```

**✅ Good mental model** (declarative):
> "This layout expresses a structure for this breakpoint"

```dart
// Good: Declarative layout
ResponsiveLayout(
  mobile: MobileLayout(),
  desktop: DesktopLayout(),
)
```

Think: **composition**, not conditions.

---

### Principle 3: Avoid Magical Behavior

**❌ Bad** (magical behavior):
> "This button becomes full width automatically"

```dart
// Bad: Component decides its width based on context
class MagicalButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return SizedBox(
      width: isMobile ? double.infinity : 200,
      child: ElevatedButton(...),
    );
  }
}
```

**✅ Good** (explicit layout):
> "This layout makes the button full width"

```dart
// Good: Layout decides button width
SizedBox(
  width: double.infinity,
  child: MyButton(),
)
```

Magic causes confusion. Be explicit.

---

### Principle 4: Layouts Are Composable

You can nest layouts for more granular control:

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Column(
        children: [
          HeaderSection(),
          ResponsiveLayout(
            mobile: ProjectListLayout(),
            tablet: ProjectGridLayout(columns: 2),
            desktop: ProjectGridLayout(columns: 3),
          ),
        ],
      ),
      desktop: Row(
        children: [
          SidebarSection(),
          Expanded(
            child: ResponsiveLayout(
              mobile: ProjectGridLayout(columns: 2),
              desktop: ProjectGridLayout(columns: 4),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### Principle 5: Layout Must Allow Change

If changing layout requires editing 40 components, your system is broken.

**A correct system lets you:**
- ✔ Swap layouts without touching components
- ✔ Change grid column counts in one place
- ✔ Adjust spacing globally
- ✔ Add new breakpoints easily

**Example**: Changing from 2-column to 3-column grid

```dart
// Before
GridView.count(crossAxisCount: 2, ...)

// After
GridView.count(crossAxisCount: 3, ...)

// Components don't change at all ✅
```

---

## Quick Reference

### Layout vs Component Responsibilities

| Concern | Layout | Component |
|---------|--------|-----------|
| Width/Height | ✅ | ❌ |
| Max-width | ✅ | ❌ |
| Column span | ✅ | ❌ |
| Grid placement | ✅ | ❌ |
| Breakpoint logic | ✅ | ❌ |
| External margins | ✅ | ❌ |
| Gaps between items | ✅ | ❌ |
| Alignment in page | ✅ | ❌ |
| Vertical rhythm | ✅ | ❌ |
| Internal padding | ❌ | ✅ |
| Visual style | ❌ | ✅ |
| States (hover/focus) | ❌ | ✅ |
| Typography | ❌ | ✅ |
| Content rendering | ❌ | ✅ |

### Layout Pattern Checklist

When creating a new page layout:

- [ ] Created separate layout widgets for each breakpoint
- [ ] Used `ResponsiveLayout` switcher
- [ ] Defined spacing in layout, not components
- [ ] Defined component widths in layout, not components
- [ ] No breakpoint logic inside components
- [ ] Components work in all layouts without modification
- [ ] Layout is declarative, not imperative
- [ ] No magical behavior (explicit sizing)
- [ ] Can change grid columns without touching components
- [ ] Can swap layouts without breaking components

### Common Layout Patterns

#### Pattern 1: Simple Responsive Grid

```dart
ResponsiveLayout(
  mobile: GridView.count(crossAxisCount: 1, children: items),
  tablet: GridView.count(crossAxisCount: 2, children: items),
  desktop: GridView.count(crossAxisCount: 3, children: items),
)
```

#### Pattern 2: Stacked on Mobile, Side-by-side on Desktop

```dart
ResponsiveLayout(
  mobile: Column(children: [sidebar, content]),
  desktop: Row(children: [sidebar, Expanded(child: content)]),
)
```

#### Pattern 3: Responsive Container Width

```dart
ResponsiveLayout(
  mobile: Padding(
    padding: EdgeInsets.all(16),
    child: content,
  ),
  desktop: Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: Padding(
        padding: EdgeInsets.all(32),
        child: content,
      ),
    ),
  ),
)
```

---

**Remember**: Layout = Structure. Component = Content. Keep them separate.
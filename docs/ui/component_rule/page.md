# Page Design Rules

> **Core Principle**: Pages compose meaning through structure. Components don't encode page-specific meaning.

---

## Widget System Mapping

The following **widget category** from the [Widget Naming System](../widget_naming_system.md) represents **"pages"** and **MUST** follow all rules in this document:

| Widget Category | Suffix | Purpose |
|----------------|--------|---------|
| **Page** | `_page` | Screen entry point and composition root |

**Examples:**
- `home_page.dart` - Home screen entry point
- `dashboard_page.dart` - Dashboard screen entry point
- `settings_page.dart` - Settings screen entry point

**Page widgets are responsible for:**
- ✅ Composition of sections
- ✅ Routing and navigation
- ✅ Data wiring (BlocProvider, state management setup)
- ✅ Delegating to `_layout` for responsive behavior
- ✅ Scaffold/AppBar setup

**Page widgets must NOT:**
- ❌ Define visual tokens (colors, spacing values)
- ❌ Style components
- ❌ Contain responsive logic directly (delegate to `_layout`)
- ❌ Listen to state (that's `_view`'s job)
- ❌ Contain business logic

**Typical page structure:**
```dart
_page
  ↓ Provides BlocProvider/DI
  ↓ Sets up Scaffold
  ↓ Delegates to:
_layout (responsive variants)
  ↓ Arranges:
_view (state-driven sections)
  ↓ Composes:
_unit, _visual, _action, _control, _input
```

**Related:**
- See [Layout Rules](layout.md) for what layouts do
- See [Component Rules](component.md) for what components do
- See [Responsive Rules](responsive.md) for breakpoint patterns

---

## Table of Contents

1. [Page Responsibilities](#page-responsibilities)
2. [Pages Are Not Components](#pages-are-not-components)
3. [Naming Conventions](#naming-conventions)
4. [Page Design Rules](#page-design-rules)
5. [Quick Reference](#quick-reference)

---

## Page Responsibilities

### What a Page SHOULD Define

- ✅ Composition of components
- ✅ Arrangement of sections
- ✅ Grouping of content
- ✅ Structure (how things are organized)
- ✅ Section grouping
- ✅ Layout switching (responsive behavior)
- ✅ Routing
- ✅ Data wiring (connecting data to components)

### What a Page MUST NOT Define

- ❌ Visual tokens (colors, spacing values, etc.)
- ❌ Design logic (typography, shadows, etc.)
- ❌ Component styling
- ❌ Spacing tokens
- ❌ Breakpoint definitions
- ❌ Visual styles
- ❌ Layout hacks
- ❌ Responsive logic directly (delegate to layouts)

---

## Pages Are Not Components

Understanding the distinction is crucial:

### Pages

Pages are responsible for:
- **Compose** - Bringing components together
- **Arrange** - Positioning sections and content
- **Group** - Organizing related elements
- **Structure** - Defining information architecture

### Components

Components are responsible for:
- **Render** - Displaying content
- **Interact** - Handling user input
- **Animate** - Providing visual feedback
- **Display** - Presenting data

> **Rule**: Don't mix page responsibilities with component responsibilities.

**Example**:

```dart
// ✅ GOOD: Page composes and structures
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: HomeMobileLayout(),
        tablet: HomeTabletLayout(),
        desktop: HomeDesktopLayout(),
      ),
    );
  }
}

// ❌ BAD: Page defines styling
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16), // ❌ Page defining spacing
        decoration: BoxDecoration(
          color: Colors.blue, // ❌ Page defining colors
        ),
        child: Column(...),
      ),
    );
  }
}
```

---

## Naming Conventions

### Never Encode Page Meaning into Components

Component names should be **generic and reusable**, not tied to specific pages.

**❌ Bad** (page-specific naming):
- `HomeHeroButton`
- `ProfileCard`
- `DashboardTile`
- `AboutPageHeader`
- `ContactFormButton`

These become impossible to reuse on other pages.

**✅ Good** (generic naming):
- `PrimaryButton`
- `ContentCard`
- `InfoTile`
- `PageHeader`
- `SubmitButton`

### Why This Matters

```dart
// ❌ BAD: Can't reuse this button elsewhere
class HomeHeroButton extends StatelessWidget {
  // This implies it only works on the home page hero section
}

// ✅ GOOD: Can use this anywhere
class PrimaryButton extends StatelessWidget {
  // This works on any page, any section
}
```

> **Remember**: Pages compose meaning. Components don't.

---

## Page Design Rules

### Rule 1: Pages Compose Components

Pages bring components together but don't style them.

**✅ Correct**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Column(
        children: [
          HeroSection(),
          AboutSection(),
          ProjectsSection(),
          ContactSection(),
        ],
      ),
      desktop: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            AboutSection(),
            ProjectsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
```

**❌ Wrong**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue, // ❌ Page styling component
          padding: EdgeInsets.all(20), // ❌ Page defining spacing
          child: HeroSection(),
        ),
      ],
    );
  }
}
```

---

### Rule 2: Pages Do Not Style Components

Styling belongs to components or theme.

**✅ Correct**:
```dart
// In page
ProjectCard(project: myProject)

// In ProjectCard component
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  ),
  child: ...,
)
```

**❌ Wrong**:
```dart
// In page
Container(
  decoration: BoxDecoration(
    color: Colors.white, // ❌ Styling in page
  ),
  child: ProjectCard(project: myProject),
)
```

---

### Rule 3: Pages Do Not Define Visual Tokens

Visual tokens (colors, spacing, typography) belong in the theme or design system.

**❌ Wrong**:
```dart
class HomePage extends StatelessWidget {
  // ❌ Defining tokens in page
  static const _primaryColor = Color(0xFF2196F3);
  static const _sectionSpacing = 32.0;
  static const _cardElevation = 4.0;
  
  @override
  Widget build(BuildContext context) {
    return Container(color: _primaryColor, ...);
  }
}
```

**✅ Correct**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ✅ Use theme tokens
    final theme = Theme.of(context);
    return Container(color: theme.colorScheme.primary, ...);
  }
}
```

---

### Rule 4: Pages Own Structure

Pages decide how sections are organized.

**✅ Correct**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileStructure(),
      desktop: _buildDesktopStructure(),
    );
  }
  
  Widget _buildMobileStructure() {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(),
          AboutSection(),
          ProjectsSection(),
        ],
      ),
    );
  }
  
  Widget _buildDesktopStructure() {
    return Row(
      children: [
        SidebarNavigation(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(),
                AboutSection(),
                ProjectsSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
```

---

### Rule 5: Pages Own Layout Switching

Pages delegate to responsive layouts, not implement responsive logic directly.

**❌ Wrong** (page implements responsive logic):
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    // ❌ Responsive logic in page
    if (width < 600) {
      return MobileLayout();
    } else if (width < 1024) {
      return TabletLayout();
    } else {
      return DesktopLayout();
    }
  }
}
```

**✅ Correct** (page delegates to ResponsiveLayout):
```dart
class HomePage extends StatelessWidget {
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

### Rule 6: Pages Own Data Wiring

Pages connect data sources to components.

**✅ Correct**:
```dart
class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state is ProjectsLoaded) {
          return ResponsiveLayout(
            mobile: ProjectsListLayout(projects: state.projects),
            desktop: ProjectsGridLayout(projects: state.projects),
          );
        }
        return LoadingSpinner();
      },
    );
  }
}
```

---

### Rule 7: Pages Must Be Predictable

Someone reading the page should understand:
- What sections exist
- How they're arranged
- What data flows where

**✅ Good** (predictable structure):
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }
  
  Widget _buildMobileLayout() {
    return Column(
      children: [
        HeroSection(),
        FeaturesSection(),
        TestimonialsSection(),
      ],
    );
  }
  
  Widget _buildDesktopLayout() {
    return Column(
      children: [
        HeroSection(),
        Row(
          children: [
            Expanded(child: FeaturesSection()),
            Expanded(child: TestimonialsSection()),
          ],
        ),
      ],
    );
  }
}
```

---

### Rule 8: Pages Must Be Readable

Keep page code clean and scannable.

**❌ Bad** (unreadable):
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [Container(child: Row(children: [Text('Hi'), Text('World')]), decoration: BoxDecoration(color: Colors.red)), SizedBox(height: 20), ...] // endless nesting
  }
}
```

**✅ Good** (readable):
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      desktop: _buildDesktopLayout(),
    );
  }
  
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildHeroSection(),
        _buildFeaturesSection(),
        _buildFooterSection(),
      ],
    );
  }
  
  Widget _buildHeroSection() => HeroSection();
  Widget _buildFeaturesSection() => FeaturesSection();
  Widget _buildFooterSection() => FooterSection();
}
```

---

### Rule 9: Pages Must Not Contain UI Hacks

If you're adding hacks, the problem is elsewhere.

**❌ Bad** (UI hacks):
```dart
// ❌ Hack: Adding SizedBox to force height
SizedBox(height: 1, child: ProjectCard())

// ❌ Hack: Using Stack for layout
Stack(children: [Positioned(left: 0, top: 0, child: Header())])

// ❌ Hack: Using Transform to adjust position
Transform.translate(offset: Offset(0, -10), child: Footer())
```

**✅ Good** (proper solutions):
```dart
// ✅ Fix the component or layout instead
ProjectCard() // Component handles its own height

// ✅ Use proper layout widgets
Column(children: [Header(), Content(), Footer()])

// ✅ Use proper positioning
Positioned.fill(child: Content())
```

---

### Rule 10: Pages Must Not Contain Responsive Logic Directly

Delegate responsive logic to `ResponsiveLayout` or layout widgets.

**❌ Wrong**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Column(
      children: [
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: isMobile ? 24 : 48, // ❌ Responsive logic in page
          ),
        ),
      ],
    );
  }
}
```

**✅ Correct**:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: WelcomeText(size: WelcomeTextSize.small),
      desktop: WelcomeText(size: WelcomeTextSize.large),
    );
  }
}
```

---

## Quick Reference

### Page vs Component vs Layout

| Concern | Page | Layout | Component |
|---------|------|--------|-----------|
| Composition | ✅ | ❌ | ❌ |
| Structure | ✅ | ❌ | ❌ |
| Routing | ✅ | ❌ | ❌ |
| Data wiring | ✅ | ❌ | ❌ |
| Section grouping | ✅ | ❌ | ❌ |
| Layout switching | ✅ | ❌ | ❌ |
| Responsive structure | ❌ | ✅ | ❌ |
| Component sizing | ❌ | ✅ | ❌ |
| Component spacing | ❌ | ✅ | ❌ |
| Breakpoint logic | ❌ | ✅ | ❌ |
| Visual styling | ❌ | ❌ | ✅ |
| Internal padding | ❌ | ❌ | ✅ |
| States (hover/focus) | ❌ | ❌ | ✅ |
| Typography | ❌ | ❌ | ✅ |
| Content rendering | ❌ | ❌ | ✅ |

### Page Design Checklist

When creating a new page:

- [ ] Page only composes components (no styling)
- [ ] Page delegates to ResponsiveLayout (no direct MediaQuery)
- [ ] Page owns routing and navigation
- [ ] Page wires data to components
- [ ] Page groups sections logically
- [ ] No visual tokens defined in page
- [ ] No spacing/padding values in page
- [ ] No breakpoint logic in page
- [ ] No UI hacks (Transform, forced heights, etc.)
- [ ] Page code is readable and scannable
- [ ] Component names are generic (not page-specific)
- [ ] Structure is predictable

### Common Page Patterns

#### Pattern 1: Simple Page with Responsive Layout

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ResponsiveLayout(
        mobile: HomeMobileLayout(),
        desktop: HomeDesktopLayout(),
      ),
    );
  }
}
```

#### Pattern 2: Page with Data Fetching

```dart
class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          return state.when(
            loading: () => LoadingSpinner(),
            loaded: (projects) => ResponsiveLayout(
              mobile: ProjectsListLayout(projects: projects),
              desktop: ProjectsGridLayout(projects: projects),
            ),
            error: (message) => ErrorView(message: message),
          );
        },
      ),
    );
  }
}
```

#### Pattern 3: Page with Navigation

```dart
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: DashboardMobileLayout(),
        desktop: DashboardDesktopLayout(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

---

**Remember**: Pages = Composition. Layouts = Structure. Components = Content. Keep them separate.
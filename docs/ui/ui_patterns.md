🛡️ Solearium UI Engineering Standards

Status: Mandatory
Target: Production Readiness
Scope: All Flutter UI Components

This document defines the 16 strict rules required to merge UI code into the production branch. These rules are designed to prevent technical debt, ensure performance, and guarantee a cohesive user experience.

🎨 I. The Visual Foundation (Theming & Style)

1. The "No Hardcoded Colors" Rule

Rule: Never use Colors.red, Color(0xFF...), or hex codes directly in a widget.

Why? Hardcoded colors break Dark Mode, Theming, and White-labeling capabilities.

Solution: strictly use context.colorScheme (Material) or context.appColors (Semantic).

2. The Typography Centralization Rule

Rule: Never manually instantiate TextStyle (e.g., TextStyle(fontSize: 16)) unless implementing a design system atom.

Why? Ensures consistent font weights, sizes, and readability across the app.

Solution: Use context.textTheme.bodyMedium. Use .copyWith() only for color or weight overrides, never for size.

3. The Strict Spacing Tokenization

Rule: No magic numbers for padding or margins. Integers (e.g., 8.0, 16.0) are banned in layout parameters.

Why? Visual consistency is impossible to maintain with raw numbers.

Solution: Use AppSpacing.m (16), AppSpacing.s (8).

Exception: 1px borders or specific graphic implementations.

4. The "No Raw Strings" Mandate (i18n)

Rule: Never put user-facing strings directly in the code (e.g., Text('Login')).

Why? It makes localization (adding new languages) impossible and complicates copy updates.

Solution: Always use generated localization keys: Text(context.l10n.loginButtonTitle).

5. The Icon Abstraction Rule

Rule: Never use Icons.home or hardcoded SVG asset paths directly in widgets.

Why? Switching icon sets (e.g., from Filled to Outlined, or Material to Custom) requires refactoring the entire codebase.

Solution: Use a centralized AppIcons class.

Icon(AppIcons.back) instead of Icon(Icons.arrow_back_ios).

AppIcons.logo instead of SvgPicture.asset('assets/logo.svg').

📱 II. Layout & Responsiveness

6. The Safe Area Mandate

Rule: All screens must handle device notches and home indicators.

Why? Content clipped by the iPhone "notch" or Android camera cutout looks amateur.

Solution: Wrap the body of your Scaffold in SafeArea, or manually apply MediaQuery.paddingOf(context) if you need edge-to-edge content.

7. The "Fluid Text" Rule

Rule: Never assume text fits on one line.

Why? Users with large accessibility font sizes or long languages (German/Russian) will cause RenderFlex overflows.

Solution:

Wrap text in Flexible or Expanded within Rows/Columns.

Use maxLines and overflow: TextOverflow.ellipsis where specific height is required.

8. The Adaptive Layout Rule

Rule: Do not use fixed screen dimensions (e.g., if (width > 375)).

Why? Fails on foldables, tablets, and split-screen modes.

Solution: Use LayoutBuilder for component-level responsiveness or standard Breakpoints (compact, medium, expanded) for page-level logic.

9. The Keyboard Awareness Rule

Rule: Input forms must handle the software keyboard gracefully.

Why? The keyboard often obscures the submit button or active input field.

Solution:

Wrap forms in SingleChildScrollView or CustomScrollView.

Verify resizeToAvoidBottomInset behavior in Scaffold.

Implement "Tap outside to dismiss" functionality.

⚡ III. Performance & Optimization

10. The const Imperative

Rule: Use const constructors wherever possible.

Why? const widgets are canonicalized and never rebuild. This effectively removes them from the widget tree rebuild cycle, drastically improving FPS.

Solution: Enable the prefer_const_constructors lint rule and auto-fix on save.

11. The Pure Build Method

Rule: Never perform heavy logic, HTTP calls, or complex formatting inside the build() method.

Why? build() can be called 60 times per second. Blocking it causes "jank" (stutter).

Solution:

Move logic to Bloc/Provider/Controller.

Move one-time formatting to initState or memoized getters.

12. The List Optimization Rule

Rule: Never use SingleChildScrollView + Column for long lists.

Why? It renders every item instantly, causing massive memory spikes and lag.

Solution: Use ListView.builder or CustomScrollView + SliverList. This lazily renders only the items currently on screen.

13. Smart Image Caching

Rule: Never use Image.network for recurring images.

Why? It redownloads the image on every scroll/rebuild, wasting data and battery.

Solution: Use CachedNetworkImage (from cached_network_image package) with proper placeholders.

♿ IV. Accessibility & UX Quality

14. The 48dp Touch Target Rule

Rule: All interactive elements must have a hit-test area of at least 48x48dp.

Why? Prevents frustration for users with larger fingers or motor impairments.

Solution: Use IconButton (built-in 48dp) or wrap smaller widgets in InkWell/GestureDetector with behavior: HitTestBehavior.translucent and adequate padding.

15. The "No Dead States" Rule

Rule: A UI screen must handle all 3 data states: Loading, Error, and Empty.

Why? A blank white screen while data loads looks broken.

Solution:

Loading: Use Shimmer effects (skeleton loaders), not just spinners.

Error: Show a friendly message with a "Retry" button.

Empty: Show a specific illustration/text when a list has 0 items.

16. Widget Extraction over Helper Methods

Rule: Use separate Widget classes instead of helper methods to split up UI.

Why? _buildHeader() helper methods rebuild every time the parent rebuilds. Separated HeaderWidget() classes can be const and skip rebuilds independently.

Solution:

// ❌ BAD
Widget _buildHeader() { ... }

// ✅ GOOD
class HeaderWidget extends


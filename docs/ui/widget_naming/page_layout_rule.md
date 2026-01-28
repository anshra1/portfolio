# Page-Level Layout Rule (`_page_layout`)

**Scope:** Arranges the entire screen or major high-level sections.
**Consumer:** Typically used directly by a `_page` widget.

## 1. Definition
A Page-Level Layout defines the **macro structure** of the application. It acts as the skeleton for the entire screen, deciding how major sections (Header, Sidebar, Content Body) relate to each other.

## 2. Responsibilities
-   **Scaffolding:** Often defines the `Scaffold`, `SafeArea`, or top-level `Row`/`Column`.
-   **Global Breakpoints:** It is the primary place for handling `Mobile vs. Tablet vs. Desktop` logic.
-   **Composition:** It consumes `_section` widgets, `_view` widgets, or other high-level `_layout` widgets.

## 3. Strict Rules
-   **❌ No Leaf Widgets:** It must NOT create `Text`, `Buttons`, or `Icons`.
-   **❌ No Business Logic:** It doesn't care about the user's role or data state.
-   **✅ Structure Only:** It uses `Row`, `Column`, `Stack`, `Flex`.

## 4. Example

```dart
// dashboard_page_layout.dart
class DashboardPageLayout extends StatelessWidget {
  const DashboardPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Decision point for Responsive Design
    final isDesktop = MediaQuery.of(context).size.width > 900;

    if (isDesktop) {
      return const _DashboardDesktopLayout();
    }
    return const _DashboardMobileLayout();
  }
}

class _DashboardDesktopLayout extends StatelessWidget {
  const _DashboardDesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(width: 250, child: SidebarSection()),
          Expanded(
            child: Column(
              children: [
                const HeaderSection(),
                Expanded(child: MainContentSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

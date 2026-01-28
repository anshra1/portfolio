# Section-Based Widget Structure

For massive or complex pages (like Product Details), we break the page down further into **Sections**. This prevents the main page file from becoming cluttered and isolates logic even further.

---

## 1. The Folder Structure (Section View)

```text
lib/features/shop/presentation/pages/product_details/
 │
 ├── product_details_page.dart
 │
 ├── sections/
 │    │
 │    ├── header_section/             <-- FOLDER
 │    │    ├── product_header_section.dart  <-- The Section File
 │    │    └── widgets/                     <-- LOCKED to this Section
 │    │         ├── gallery_thumbnail.dart
 │    │         ├── flash_sale_timer.dart
 │    │         └── color_variant_picker.dart
 │    │
 │    └── feedback_section/           <-- FOLDER
 │         ├── product_feedback_section.dart
 │         └── widgets/                     <-- LOCKED to this Section
 │              ├── rating_bar.dart
 │              └── user_comment_bubble.dart
 │
 └── widgets/                         <-- Page-Level Widgets (Used by multiple sections)
      ├── product_sticky_bottom_bar.dart
```

## 2. The Widget Tree (Runtime View)
This creates a very clean hierarchy.

```text
ProductDetailsPage
 └── Column
      │
      ├── ProductHeaderSection        <-- The Section
      │    ├── ImageGallery
      │    │    └── GalleryThumbnail  <-- Section-Level Widget (Deepest)
      │    │
      │    ├── FlashSaleTimer         <-- Section-Level Widget (Deepest)
      │    └── ColorVariantPicker     <-- Section-Level Widget (Deepest)
      │
      ├── ProductFeedbackSection
      │    ├── RatingBar              <-- Section-Level Widget (Deepest)
      │    └── UserCommentBubble      <-- Section-Level Widget (Deepest)
      │
      └── ProductStickyBottomBar      <-- Page-Level Widget (Sibling to Sections)
```

## 3. Code Example: How it Looks

The goal is for the main page file to be clean, readable, and under 100 lines. The application coordinates the sections.

### A. The Main Page File (`product_details_page.dart`)

```dart
class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductHeaderSection(),      // <--- Clean!
            Divider(),
            ProductContentSection(),     // <--- Clean!
            Divider(),
            ProductFeedbackSection(),    // <--- Clean!
          ],
        ),
      ),
      bottomNavigationBar: AddToCartStickyBar(), // Keep sticky elements on page level
    );
  }
}
```

### B. A Section File (`sections/product_feedback_section.dart`)
Goal: Handles the layout logic for this specific part of the page.

```dart
class ProductFeedbackSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer Reviews", style: Styles.h2),
          SizedBox(height: 16),
          ReviewHistogram(),           // <--- Uses Local Widget
          SizedBox(height: 24),
          // We can write simple layout logic here without cluttering the main page
          ReviewListTile(user: "User A", stars: 5),
          ReviewListTile(user: "User B", stars: 4),
          Center(
            child: TextButton(onPressed: () {}, child: Text("View All")),
          )
        ],
      ),
    );
  }
}
```

## 4. Formal Definition of `_section`

**Definition:** A high-level composite widget that defines a major area of the page (e.g. Hero, Footer).

**Purpose:** Groups multiple smaller components (`_visual`, `_action`, `_unit`) into a coherent block.

**Rules:**
✅ **Allowed:**
- Compose multiple widgets
- Use `context` (Theme, Breakpoints via Layouts)

❌ **Forbidden:**
- Business Logic (use `_view` if it needs to listen to BLoC)
- Complex Layout Logic (delegate to `_layout` if complex)

**Examples:**
```dart
// ✅ VALID
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroTitleVisual(),
        HeroActionsLayout(),
      ],
    );
  }
}
```

---

**See also:**
- [Page-Based Widget Structure](page_based_widget_structure.md) for page and layout organization.
- [Widget Naming System](widget_naming_system.md) for strict class naming rules.


# Widget Structure Guidelines

This document outlines the structural patterns for organizing widgets within the application. We follow a "Local First" approach, where widgets are kept as close as possible to where they are used.

## 1. Global Core Widgets (Atomic Design)

For widgets that are used across the entire application (not specific to a single feature), we use the **Atomic Design** system located in `lib/src/core/widgets`.

### The Folder Structure
```text
lib/src/core/widgets/
 ├── atoms/         <-- Basic building blocks (Buttons, Inputs, Texts)
 ├── molecules/     <-- Groups of atoms (Search Bars, User Class Cards)
 ├── organisms/     <-- Complex UI sections (Headers, Footers)
 ├── template/      <-- Page layouts without content
 └── pages/         <-- (Rarely used here, mostly for generic status pages)
```

**Rule:** If a widget is used in **2 or more features**, strictly move it here.

## 2. Page-Based Structure

The fundamental building block of our app is the **Page**. Each page folder should be a self-contained universe.

### The Folder Structure (Project View)

```text
lib/features/shop/presentation/
 │
 ├── shared_widgets/                     <-- FEATURE-LEVEL SHARED
 │    ├── shop_product_card.dart         <-- Promoted! Used by Search & Details
 │    └── shop_sale_badge.dart           <-- Promoted! Used by Card & Details
 │
 └── pages/
      ├── search/
      │    ├── search_page.dart
      │    └── widgets/                  <-- Local (Private)
      │         ├── search_input_bar.dart
      │         └── search_result_grid.dart (Imports ShopProductCard)
      │
      ├── product_details/
      │    ├── product_details_page.dart
      │    └── widgets/                  <-- Local (Private)
      │         ├── product_image_carousel.dart
      │         ├── product_info_card.dart (Imports ShopSaleBadge)
      │         └── similar_products_list.dart (Imports ShopProductCard)
      │
      └── profile/
           ├── profile_page.dart
           └── widgets/                  <-- Local (Private)
                └── profile_header_card.dart
```

### Deep Dive: Example Pages

Here is how the Widget Trees look for specific pages using this structure.

#### A. Search Page
*Context:* This page handles finding items. Even though `SearchInputBar` looks like a text field, we keep it here because it has specific logic (debounce, auto-focus) that other pages don't need.

**The Widget Tree (Runtime):**
```text
SearchPage (Scaffold)
 └── Column
     ├── SearchInputBar           <-- (1) The text field area
     ├── SearchFilterChips        <-- (2) Row: [Price] [Color] [Brand]
     └── Expanded
          └── Stack
               ├── SearchEmptyState     <-- (3) "No results found" image
               ├── ListView
               │    ├── SearchPromoBanner    <-- (4) "50% Off Nike"
               │    ├── SearchRecentHistory  <-- (5) "Last searched: Puma"
               │    └── SearchResultGrid     <-- (6) The actual products
```

#### B. Profile Page
*Context:* This page displays user settings. It has a completely different look from the rest of the app.

**The Widget Tree (Runtime):**
```text
ProfilePage (Scaffold)
 └── SingleChildScrollView
      └── Column
           ├── ProfileHeaderCard        <-- (1) User Photo & Name
           ├── ProfileWalletBadge       <-- (2) "Balance: $50.00"
           ├── ProfileOrderSummary      <-- (3) "Last order: Arriving Today"
           ├── Padding (Divider)
           ├── ProfileMenuOptions       <-- (4) "Account", "Privacy", "Help"
           ├── Row
           │    ├── Text("Dark Mode")
           │    └── ProfileDarkModeSwitch <-- (5) Toggle Switch
           └── ProfileLogoutButton      <-- (6) Red button at bottom
```

### Why this is better
1.  **No "God Classes":**
    *   Intern A works on `SearchInputBar`.
    *   Intern B works on `ProfileHeaderCard`.
    *   They never touch the same file. Merge conflicts are zero.
2.  **Context in Names:**
    *   If you see a file named `ProfileWalletBadge`, you know *exactly* what it does.
    *   If you named it just `WalletBadge`, you might be tempted to use it on the Checkout page, which breaks the "Local First" rule.
3.  **Specific Logic:**
    *   The `SearchInputBar` needs to trigger an API call when typing stops.
    *   The `ProfileDarkModeSwitch` needs to save a preference to local storage.
    *   By separating them, you don't have one complex widget trying to handle both API calls and Local Storage.

---

## 3. Section-Based Structure

For massive or complex pages (like Product Details), we break the page down further into **Sections**. This prevents the main page file from becoming cluttered and isolates logic even further.

### The Folder Structure (Section View)

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

### The Widget Tree (Runtime View)
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

### Code Example: How it Looks
The goal is for the main page file to be clean, readable, and under 100 lines. application coordinates the sections.

#### A. The Main Page File (`product_details_page.dart`)

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

#### B. A Section File (`sections/product_feedback_section.dart`)
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



# Feature: Articles

## Intent

The Articles feature provides a structured, searchable, and readable knowledge base for blog posts and tutorials. It allows users to discover written content efficiently and consume long-form articles in a focused reading experience.

The feature is strictly read-only and optimized for clarity, discoverability, and predictable behavior.

---

## Scope

### In Scope

*   Display a list of articles
*   Support searching, filtering, and sorting (Ranked Results)
*   Load and display full article content
*   Provide a distraction-free reading experience

### Out of Scope

*   Writing or editing articles
*   Comments, likes, or reactions
*   Offline reading
*   Bookmarking or saving articles
*   Analytics or tracking

---

## Feature-Owned Entities

### Article

Represents a blog post or tutorial.

**Responsibilities:**

*   Provide identity for routing and lookup
*   Expose metadata for discovery (title, date, tags, summary)
*   Support lightweight rendering in list and grid views
*   **Implementation Note:** Implemented as a **Unified Model** (Single `Article` entity). The `content` field is lazy-loaded via the `contentPath`.

---

## Public Methods (Feature API)

*   `getArticles({int page, int limit, ArticleFilter filter})`
*   `getArticleDetail(String articleId)`

---

## Feature-Level Architectural Decisions

### Data Source Strategy

*   **Registry & Content Pattern:** Data is split between a metadata index and individual content files.
*   **Storage Root:** All feature data is stored in the `database/articles/` directory.
*   All reads are asynchronous to simulate remote fetching.

### Content & Asset Organization

Articles use a **Component Folder** strategy to keep text and related assets together:

*   **Registry Index:** `database/articles/articles.json` (Metadata only).
*   **Article Bundles:** Each article has its own directory under `database/articles/content/` containing:
    *   `index.md` (The full content).
    *   Local images and assets specific to that article.
*   **Image Paths:** Markdown files must use **Project-Root relative paths** (e.g., `database/articles/content/my_article/image.png`) to ensure Flutter AssetBundle compatibility.

### Pagination Policy

*   **Infinite Scroll:** Data is loaded in chunks.
*   The API returns a subset of items based on `page` and `limit`.
*   An empty list signifies the end of the dataset.

### Filtering & Sorting Policy

*   **Ranked Search Algorithm:**
    1.  **Primary Sort:** `DisplayTier` (Hero > Standard)
    2.  **Secondary Sort:** `publishedAt` (Newest > Oldest)
*   **Supported Filters:**
    *   Search query (title)
    *   Tag selection

### Caching Policy

*   No persistent cache.
*   No in-memory reuse across calls.

### Offline Behavior

*   **Fail-fast:** Offline state immediately returns a failure.

### Error Handling Model

*   All public methods return `Result<T, Failure>`.
*   Technical exceptions are mapped to domain failures.

---

## Data Model: Article

**Definition:** Represents a blog post or tutorial.

### 1. Core Fields (Traceability)

*   `id`: String — **Logic:** Unique identifier for routing.
*   `displayTier`: Enum (Hero, Standard, Hidden) — **Logic:** Controls ranking and visual prominence.
*   `publishedAt`: DateTime — **Logic:** Used for chronological sorting and secondary ranking.
*   `title`: String — **UI:** Headline on Card and Detail Screen.
*   `readTime`: String — **UI:** Estimated reading time.
*   `summary`: String — **UI:** Short excerpt for the Card view.
*   `contentPath`: String — **Logic:** Path to the physical Markdown file in the database.
*   `tags`: List<String> — **UI:** Filtering criteria and UI chips.
*   `coverImageAsset`: String — **UI:** Local asset path for the cover image.

### 2. Relationships

*   None.

### 3. Mock Data Structure (JSON)

```json
{
  "id": "a1",
  "displayTier": "hero",
  "publishedAt": "2024-11-25T10:00:00Z",
  "title": "Component-first UI speeds development",
  "readTime": "3 min",
  "tags": ["#UI/UX", "#Flutter"],
  "summary": "Build reusable components first, then compose scalable UI.",
  "contentPath": "database/articles/content/component_ui/index.md",
  "coverImageAsset": "database/articles/content/component_ui/cover.jpg"
}
```

---

## Method Specifications

### Method: getArticles

**Purpose:** Provide a discoverable list of articles based on current user intent. This method returns a **Ranked Result Set** where the most significant content (Hero tier) is automatically promoted to the top.

**Input:**

*   `page` (int, optional)
*   `limit` (int, optional)
*   `filter` (ArticleFilter, optional)

**Output:**

*   `List<Article>`

**Data Flow:**

1.  Validate incoming filter and pagination parameters.
2.  Retrieve the full article dataset from `articles.json` (Registry).
3.  Apply search filtering if a query is present.
4.  Apply tag-based filtering if a tag is selected.
5.  **Apply Ranked Sorting:** Sort by Tier (Hero first), then by Date (Newest first).
6.  Apply pagination (slice the list based on page and limit).
7.  Return the processed article list to the caller.

---

### Method: getArticleDetail

**Purpose:** Retrieve the complete reading content and metadata for a single article.

*   **Primary Role:** **Content Hydrator & Deep Link Handler.**
*   **Mandatory Use:** Unlike the Projects feature, this method **must** be called for every article view (including standard navigation), as the full article content is stored in external files and is not available in the list-view metadata.
*   **Guarantee:** Returns a fully hydrated `Article` entity where the `content` field is populated with the Markdown text.

**Input:**

*   `articleId` (String)

**Output:**

*   `Article` (Unified Model)

**Data Flow:**

1.  Validate the article identifier.
2.  Locate the article metadata in the Registry.
3.  **Hydrate Content:** Read the file at `contentPath` (e.g., `database/articles/content/.../index.md`).
4.  Populate the `content` field of the Article model.
5.  Return the complete article detail to the caller.
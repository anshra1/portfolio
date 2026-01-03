# Feature: Articles

## Intent

The Articles feature provides a structured, searchable, and readable knowledge base for blog posts and tutorials. It allows users to discover written content efficiently and consume long-form articles in a focused reading experience.

The feature is strictly read-only and optimized for clarity, discoverability, and predictable behavior.

---

## Scope

### In Scope

* Display a list of articles
* Support searching, filtering, and sorting (Ranked Results)
* Load and display full article content
* Provide a distraction-free reading experience

### Out of Scope

* Writing or editing articles
* Comments, likes, or reactions
* Offline reading
* Bookmarking or saving articles
* Analytics or tracking

---

## Feature-Owned Entities

### Article

Represents an article in a list or summary context.

Responsibilities:

* Provide identity for routing and lookup
* Expose metadata required for discovery (title, date, tags, summary)
* Support lightweight rendering in list and grid views
* **Computed Logic:** Expose `isFeatured` getter (checks if Tier is `hero`) for UI styling.

---

### ArticleDetail

Represents the full reading view of an article.

Responsibilities:

* Expose the full content body (HTML / Markdown)
* Provide complete metadata for the reader view
* Act as the single source of truth for article content

---

## Public Methods (Feature API)

* `getArticles({int page, int limit, ArticleFilter filter})`
* `getArticleDetail(String articleId)`

---

## Feature-Level Architectural Decisions

### Data Source Strategy

* Data is loaded from a simulated remote source (local JSON assets)
* All reads are asynchronous

### Pagination Policy

* Infinite Scroll: Data is loaded in chunks
* The API returns a subset of items based on `page` and `limit`
* An empty list signifies the end of the dataset

### Filtering & Sorting Policy

* **Ranked Search Algorithm:**
  1.  **Primary Sort:** `DisplayTier` (Hero > Standard)
  2.  **Secondary Sort:** `publishedAt` (Newest > Oldest)
* **Supported Filters:**
  * Search query (title + summary)
  * Tag selection

### Caching Policy

* No persistent cache
* No in-memory reuse across calls

### Offline Behavior

* Fail-fast: offline state immediately returns a failure

### Error Handling Model

* All public methods return `Result<T, Failure>`
* Technical exceptions are mapped to domain failures

---

## Feature-Level Failures

* NetworkFailure
* ServerFailure
* DataParsingFailure
* NotFoundFailure
* ValidationFailure

---

### Data Model: Article

Definition:

Represents a blog post or tutorial.

**1. Core Fields (Traceability)**

- `id`: String — **Logic:** Unique identifier for routing.
- `displayTier`: Enum (Hero, Standard, Hidden) — **Logic:** Controls ranking and visual prominence.
- `publishedAt`: DateTime — **Logic:** Used for chronological sorting and secondary ranking.
- `title`: String — **UI:** Headline on Card and Detail Screen.
- `readTime`: String — **UI:** Estimated reading time.
- `summary`: String — **UI:** Short excerpt for the Card view.
- `contentBody`: HTML/Markdown — **UI:** Full rich-text content.
- `tags`: List<String> — **UI:** Filtering criteria and UI chips.
- `coverImageAsset`: String — **UI:** Local asset path.

**2. Relationships**

- None.

**3. Mock Data Structure (JSON)**

```json
{
  "id": "a1",
  "displayTier": "hero",
  "publishedAt": "2024-11-25T10:00:00Z",
  "title": "Component-first UI speeds development",
  "readTime": "3 min",
  "tags": ["#UI/UX", "#Flutter"],
  "summary": "Build reusable components first, then compose scalable UI.",
  "contentBody": "<p>On a recent project, I began by composing small, reusable widgets...</p>",
  "coverImageAsset": "assets/images/articles/component_ui.jpg"
}
```

---

## Method Specifications

### Method: getArticles

**Purpose (Detailed)**
Provide a discoverable list of articles based on current user intent. This method returns a **Ranked Result Set** where the most significant content (Hero tier) is automatically promoted to the top.

---

**Input**

* `page` (int, optional)
* `limit` (int, optional)
* `filter` (ArticleFilter, optional)

**Output**

* `List<Article>`

---

**Inherited Feature Decisions**

* Infinite Scroll (Chunk-based loading)
* No cache
* Fail-fast offline

---

**Data**

* Retrieve the complete article dataset from the local JSON asset
* Parse raw JSON into domain entities

**Data Repository**

* **Role:** Logic Engine & Pagination
* Applies filtering and the **Ranked Sorting** algorithm in-memory.
* Slices the list based on `page` and `limit`.

---

**High-Level Functional Flow**

1. Validate incoming filter and pagination parameters
2. Retrieve the full article dataset
3. Apply search filtering if a query is present
4. Apply tag-based filtering if a tag is selected
5. **Apply Ranked Sorting:** Sort by Tier (Hero first), then by Date (Newest first).
6. Apply pagination (slice the list based on page and limit)
7. Return the processed article list to the caller

---

**Edge Cases**

* No articles exist in the dataset
* Filters produce zero matching results

---

**Failures**

* NetworkFailure
* ServerFailure
* DataParsingFailure

---

### Method: getArticleDetail

**Purpose (Detailed)**
Retrieve the complete reading content for a single article.

---

**Input**

* `articleId` (String)

**Output**

* `ArticleDetail`

---

**High-Level Functional Flow**

1. Validate the article identifier
2. Locate the article matching the identifier
3. Load the full content body and metadata
4. Return the complete article detail to the caller

---

**Failures**

* ValidationFailure
* NotFoundFailure
* NetworkFailure
* DataParsingFailure

---

## Final Notes

* This feature is read-only by design
* All business logic must live outside the UI layer
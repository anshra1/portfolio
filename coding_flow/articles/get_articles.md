# Plain-English Method Design Shell: getArticles

## 1. Project Feature Name

**Articles Feature**

**Role:**
Provides a structured, searchable, and readable knowledge base for blog posts and tutorials. This method is the primary data pipeline for the article discovery interface.

## 2. Method Name

`getArticles`

**Role:**
A single, testable unit of behavior that retrieves a paginated, filtered, and ranked list of article metadata from the local data store.

## 3. Method Responsibility

**Role:**
Defines exactly what the method is accountable for.

*   **Retrieve** the raw article dataset from the local JSON registry.
*   **Validate** and sanitize pagination and filter inputs.
*   **Filter** articles based on Visibility (`DisplayTier`), Search Query, and Tag selection.
*   **Rank** articles according to a strict Tier-Based Ranking (Hero > Standard) combined with chronological sorting (Newest first).
*   **Paginate** the results in-memory based on the requested page and limit.
*   **Recover** partially from data corruption by discarding invalid records while keeping valid ones (Valid-Subset Recovery).
*   **Map** technical failures (IO/Parsing) to Domain Failures.

## 4. Datasource (The Mechanism)

**Focus:** Pure IO interaction, Serialization, Schema Validation, and In-Memory Caching.

### 4.1 Full Method Working (Plain English)

**Step 1:** Check if the articles list is already cached in memory (`_cachedArticles`).
   *   **1a (Cached):** Skip to Step 6.
   *   **1b (Not Cached):** Proceed to Step 2.
**Step 2:** Access the `database/articles/articles.json` file from the application bundle.
**Step 3:** Read the file content as a raw string and decode it into a generic JSON List.
**Step 4:** Iterate through each JSON object in the list:
   *   **4a:** Attempt to parse the object into an `ArticleModel` (DTO).
   *   **4b (Success):** Add the model to the result list.
   *   **4c (Schema Failure):** If a mandatory field (`id`, `title`, `contentPath`) is missing or a type mismatch occurs, catch the error, **log a warning** via the Talker service ("Skipping corrupt article record"), and **discard** the record. Continue to the next item.
**Step 5:** Store the list of valid `ArticleModel`s in the in-memory cache.
**Step 6:** Convert the cached list of `ArticleModel`s into `Article` entities using `.toEntity()`.
   *   **Note:** In this flow, the `content` field of the Entity will be `null` as it is not present in the registry.
**Step 7:** Return the list of entities.

### 4.2 Context & Inputs

**Services:**
*   `AssetBundle`: To read the file.
*   `Talker`: To log warnings for skipped records.

**Data:**
*   File Path: `database/articles/articles.json`.

### 4.3 Architectural Decisions

*   **In-Memory Caching:** The parsed list is cached after the first successful load to eliminate redundant I/O for pagination and filtering.
*   **Valid-Subset Recovery:** Prioritizes feature availability. A single corrupt record (type mismatch) in the JSON registry is logged and discarded, allowing the rest of the list to load.
*   **Isolate-Based Parsing:** Raw JSON decoding and DTO mapping are offloaded to a background Isolate (Web Worker on Web) to prevent blocking the UI main thread.
*   **Initialization Lock:** Concurrent calls to fetch data while the cache is empty share a single initialization Future to prevent redundant I/O.
*   **Raw I/O Only:** The Datasource does not filter or sort. It provides the entire valid dataset to the Repository.

### 4.4 Edge Case Strategy (Datasource)

*   **Missing Asset File:** Throws `DataParsingException` (Explicit failure for infrastructure issues).
*   **Malformed JSON:** Throws `DataParsingException` (Strict failure for registry corruption).

## 5. Repository (The Policy)

**Focus:** Coordination, Filtering, Ranking, and Pagination.

### 5.1 Full Method Working (Plain English)

**Step 1:** **Sanitize Inputs:**
   *   If `page` < 1, set `page` to 1.
   *   If `limit` is null or <= 0, set `limit` to 10 (Default).
   *   Normalize `filter.searchQuery`: Trim whitespace and convert to lowercase.
   *   Normalize `filter.tags`: Ensure tag matching will be case-insensitive.

**Step 2:** **Fetch Data:** Call the Datasource to retrieve the complete list of articles.

**Step 3:** **Deduplication:**
   *   Process the list to ensure unique IDs. If a duplicate ID is found, the **first instance** is kept, and subsequent ones are silently logged as errors.

**Step 4:** **Filter: Visibility:**
   *   Remove any article where `displayTier` is `ArticleDisplayTier.hidden`.

**Step 5:** **Filter: Tags:**
   *   If `filter.tags` is not empty, keep only articles where the `tags` list contains at least one of the requested tags (case-insensitive check).

**Step 6:** **Filter: Search Query:**
   *   If the normalized query is not empty:
   *   Keep articles where the `title` (lowercased) contains the query string using **Literal String Matching** (resilient to special characters).

**Step 7:** **Rank: Tier-Preserving Strategy:**
   *   **Primary Sort:** `ArticleDisplayTier` (Hero [0] > Standard [1]).
   *   **Secondary Sort:** `publishedAt` (Newest first).
   *   **Tie-Breaker:** If Tier and Date are identical, sort alphabetically by `id`.

**Step 8:** **Paginate:**
   *   Calculate `startIndex = (page - 1) * limit`.
   *   **Check:** If `startIndex` >= `filteredList.length`, return `Right([])` (Empty List).
   *   Calculate `endIndex = min(startIndex + limit, totalLength)`.
   *   Extract the sublist from `startIndex` to `endIndex`.

**Step 9:** Return the sublist as `Right(List<Article>)`.

### 5.2 Context & Inputs

**Services:**
*   `ArticlesRemoteDataSource`: To fetch the raw data.

**Data:**
*   `int page`.
*   `int? limit`.
*   `ArticleFilter? filter`.

### 5.3 Architectural Decisions

*   **Logic Ownership:** All business rules regarding what constitutes a "Hero" vs "Standard" ranking and how tags are matched reside in the Repository.
*   **Resilient Searching:** Literal matching is used to avoid RegEx injection or crashes from special characters.
*   **Strict Error Mapping:** Technical exceptions (e.g., File missing) are caught by the Repository and returned as `DataParsingFailure`.

## 6. Full Working Flow (Datasource → Repository)

**Step 1:** The UI requests `getArticles(page: 1, filter: { searchQuery: "Clean" })`.
**Step 2:** The Repository sanitizes inputs and requests all articles from the Datasource.
**Step 3:** The Datasource checks its cache; if empty, it reads `articles.json`, discards corrupt records, and caches the rest.
**Step 4:** The Repository receives the articles and filters out "Hidden" ones.
**Step 5:** The Repository filters by the query "clean" (case-insensitive) against article titles.
**Step 6:** The Repository sorts the results: Hero articles first, then by date.
**Step 7:** The Repository slices the first 10 items (Page 1).
**Step 8:** The Repository returns `Right(List<Article>)` to the Bloc/UI.

## 7. Notes

*   **Performance:** In-memory processing is chosen due to the local-asset nature of the data and expected small dataset size (< 200 articles).
*   **Deep Links:** This list view provides the `contentPath` but NOT the `content`. The UI must use `getArticleDetail` to load the actual markdown.

## 8. Clarifying Questions Resolved
*   Search/Tags are case-insensitive.
*   `content` field is `null` in the entity for this method.
*   Sorting tie-breaker is `id`.

## 9. Gap Detection & Missing Details
*   The `ArticleFilter` entity needs to support a list of tags for the filtering logic to be fully implemented as described.

## 10. Assumptions Made
*   `database/articles/articles.json` is the correct relative path from the project root.
*   `Talker` is the approved logging service.

# Plain-English Method Design Shell: getProjects

## 1. Project Feature Name

**Projects Feature**

**Role:**
Allows users to discover, filter, and view the portfolio's body of work. This method is the primary data pipeline for the project list screen.

## 2. Method Name

`getProjects`

**Role:**
A single, testable unit of behavior that retrieves a paginated, filtered, and sorted list of projects from the local data store.

## 3. Method Responsibility

**Role:**
Defines exactly what the method is accountable for.

*   **Retrieve** the raw project dataset from the local JSON asset.
*   **Validate** and sanitize pagination and filter inputs.
*   **Filter** projects based on Visibility (`DisplayTier`), Search Query, and Technology tags.
*   **Sort** projects according to a strict Tier-Based Ranking (Hero > Showcase > Standard) combined with user-selected order (Date/Popularity).
*   **Paginate** the results in-memory based on the requested page and limit.
*   **Recover** partially from data corruption by discarding invalid records while keeping valid ones (Valid-Subset Recovery).
*   **Map** technical failures (IO/Parsing) to Domain Failures.

## 4. Datasource (The Mechanism)

**Focus:** Pure IO interaction, Serialization, and Schema Validation. No business filtering or sorting.

### 4.1 Full Method Working (Plain English)

**Step 1:** Access the `assets/data/projects.json` file from the application bundle.
**Step 2:** Read the file content as a raw string.
**Step 3:** Decode the string into a generic JSON List.
**Step 4:** Iterate through each JSON object in the list:
   *   **4a:** Attempt to parse the object into a `ProjectModel` (DTO).
   *   **4b (Success):** Add the model to the result list.
   *   **4c (Schema Failure):** If a mandatory field (`id`, `title`) is missing or a type mismatch occurs (`TypeError`), catch the error using a catch-all `on Object` block, **log a warning** via the Talker service ("Skipping corrupt project record"), and **discard** the record. Continue to the next item.
**Step 5:** Convert the list of valid `ProjectModel`s into `Project` entities.
**Step 6:** Return the list of entities.

### 4.2 Context & Inputs

**Services:**
*   `AssetBundle` (or `rootBundle`): To read the file.
*   `Talker`: To log warnings for skipped/corrupt records.

**Data:**
*   File Path: `assets/data/projects.json`.

### 4.3 Edge Cases

*   **JSON Syntax Corruption:** The file exists but contains invalid JSON (e.g., missing comma).
    *   *Behavior:* Catch `FormatException`, Throw `DataParsingException`.
*   **Asset Missing:** The `projects.json` file is not found.
    *   *Behavior:* Catch `FileSystemException`, Throw `DataParsingException`.
*   **Schema Violation (Partial):** Individual records define a valid JSON object but miss required fields.
    *   *Behavior:* Log error, discard record, return valid subset.

### 4.4 Architectural Decisions

*   **In-Memory Caching:** The parsed list of projects is cached in memory (`_cachedProjects`) after the first successful load. This eliminates redundant I/O and parsing overhead for subsequent calls (e.g., filtering or pagination).
*   **Valid-Subset Recovery:** We prioritize feature availability over strict data consistency. A single bad record should not crash the entire portfolio.
*   **Raw I/O Only:** The Datasource does **not** filter or sort. It returns the *entire* valid dataset to the Repository.

### 4.5 Test Cases

**Test Case ID: DS-001**
*   **Category:** Datasource
*   **Scenario:** Successful retrieval of valid project data.
*   **Preconditions:** `assets/data/projects.json` exists and contains a list of fully valid project objects.
*   **Action:** Call `getProjects` on the Datasource.
*   **Expected Outcome:** Returns a list of `Project` entities matching the JSON data perfectly.
*   **Traceability:** Datasource Step 4b, Step 5.

**Test Case ID: DS-002**
*   **Category:** Datasource
*   **Scenario:** Asset file is missing from the bundle.
*   **Preconditions:** `assets/data/projects.json` does not exist.
*   **Action:** Call `getProjects` on the Datasource.
*   **Expected Outcome:** Throws `DataParsingException`.
*   **Traceability:** Datasource Edge Case: Asset Missing.

**Test Case ID: DS-003**
*   **Category:** Datasource
*   **Scenario:** JSON file contains invalid syntax (e.g., missing comma).
*   **Preconditions:** `assets/data/projects.json` contains malformed JSON text.
*   **Action:** Call `getProjects` on the Datasource.
*   **Expected Outcome:** Throws `DataParsingException`.
*   **Traceability:** Datasource Edge Case: JSON Syntax Corruption.

**Test Case ID: DS-004**
*   **Category:** Datasource
*   **Scenario:** Valid-Subset Recovery (Partial Schema Violation).
*   **Preconditions:** `assets/data/projects.json` contains 3 objects: 1. Valid Project A, 2. Invalid Project B (Missing `id`), 3. Valid Project C.
*   **Action:** Call `getProjects` on the Datasource.
*   **Expected Outcome:** Returns a list containing only Project A and Project C. Project B is silently discarded.
*   **Traceability:** Datasource Step 4c, Edge Case: Schema Violation.

**Test Case ID: DS-005**
*   **Category:** Datasource
*   **Scenario:** Logging of corrupt records during recovery.
*   **Preconditions:** `assets/data/projects.json` contains a record missing mandatory fields.
*   **Action:** Call `getProjects` on the Datasource.
*   **Expected Outcome:** The Talker service receives a log message indicating a skipped record.
*   **Traceability:** Datasource Step 4c (Monitoring Requirement).

## 5. Repository (The Policy)

**Focus:** Coordination, Filtering, Sorting, and Pagination.

### 5.1 Full Method Working (Plain English)

**Step 1:** **Sanitize Inputs:**
   *   If `page` < 1, set `page` to 1.
   *   If `limit` is null or <= 0, set `limit` to 6 (Default).
   *   Normalize `filter.searchQuery`: Trim whitespace and convert to lowercase.

**Step 2:** **Fetch Data:** Call the Datasource to retrieve the complete list of projects.

**Step 3:** **Filter: Visibility:**
   *   Remove any project where `displayTier` is `DisplayTier.hidden`.

**Step 4:** **Filter: Technology:**
   *   If `filter.technology` is provided, keep only projects where `technologies` list contains the exact string (case-insensitive check).

**Step 5:** **Filter: Search Query:**
   *   If the normalized query is not empty:
   *   Keep projects where `title`, `tagline`, or `description` (lowercased) contains the query.

**Step 6:** **Sort: Tier-Preserving Strategy:**
   *   **Primary Sort:** `DisplayTier` (Hero [0] > Showcase [1] > Standard [2]).
   *   **Secondary Sort:** `filter.sortOrder`
       *   *Newest / Popular:* `publishedAt` Descending.
       *   *Oldest:* `publishedAt` Ascending.
   *   **Tie-Breaker:** If Tier and Date are identical, sort alphabetically by `id`.

**Step 7:** **Paginate:**
   *   Calculate `startIndex = (page - 1) * limit`.
   *   **Check:** If `startIndex` >= `filteredList.length`, return an Empty List `[]`.
   *   Calculate `endIndex = min(startIndex + limit, totalLength)`.
   *   Extract the sublist from `startIndex` to `endIndex`.

**Step 8:** Return the sublist as `Right(List<Project>)`.

### 5.2 Context & Inputs

**Services:**
*   `ProjectsRemoteDataSource`: To fetch the raw data.

**Data:**
*   `int page`: 1-based page index.
*   `int? limit`: Items per page.
*   `ProjectFilter`: Contains `searchQuery`, `technology`, and `sortOrder`.

### 5.3 Edge Cases

*   **Pagination Out of Bounds:** Requesting a page that doesn't exist.
    *   *Behavior:* Return `Right([])` (Empty List).
*   **Invalid Inputs:** Negative page numbers.
    *   *Behavior:* Clamp to Page 1.
*   **Search Noise:** Query string is just spaces.
    *   *Behavior:* Trim and ignore (do not filter).
*   **Unstable Sort:** Projects with identical dates.
    *   *Behavior:* Apply `id` as a deterministic tie-breaker.

### 5.4 Architectural Decisions

*   **In-Memory Processing:** Since the dataset is small (Portfolio scale < 100 items), filtering and sorting are performed in memory rather than requiring a database engine.
*   **Tier-Preservation:** Business rules dictate that "Hero" projects must always appear first, regardless of the user's date-sorting preference.

### 5.5 Test Cases

**Test Case ID: REP-001**
*   **Category:** Repository
*   **Scenario:** Input Sanitization (Invalid Pagination).
*   **Preconditions:** Datasource returns valid projects. Caller requests `page: -1` and `limit: 0`.
*   **Action:** Call `getProjects` on the Repository.
*   **Expected Outcome:** Returns projects for Page 1 with the default limit (6).
*   **Traceability:** Repository Step 1, Edge Case: Invalid Inputs.

**Test Case ID: REP-002**
*   **Category:** Repository
*   **Scenario:** Filtering by Visibility (Hidden Projects).
*   **Preconditions:** Datasource returns a mix of `hero`, `standard`, and `hidden` projects.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Result list contains NO projects with `DisplayTier.hidden`.
*   **Traceability:** Repository Step 3.

**Test Case ID: REP-003**
*   **Category:** Repository
*   **Scenario:** Filtering by Technology (Case-Insensitive).
*   **Preconditions:** Datasource has projects with tags ["Flutter"], ["React"]. Caller requests `filter.technology: "flutter"`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Returns only the project with the "Flutter" tag.
*   **Traceability:** Repository Step 4.

**Test Case ID: REP-004**
*   **Category:** Repository
*   **Scenario:** Search Query Noise Handling.
*   **Preconditions:** Datasource has a project titled "Portfolio". Caller requests `filter.searchQuery: "  portfolio  "`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Returns the "Portfolio" project (Query is trimmed and lowercased).
*   **Traceability:** Repository Step 1, Step 5, Edge Case: Search Noise.

**Test Case ID: REP-005**
*   **Category:** Repository
*   **Scenario:** Tier-Preserving Sort Order.
*   **Preconditions:** Datasource returns: 1. Standard Project (Date: 2024), 2. Hero Project (Date: 2020). Caller requests `sortOrder: Newest`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** The "Hero" project appears BEFORE the "Standard" project, despite being older.
*   **Traceability:** Repository Step 6 (Primary Sort).

**Test Case ID: REP-006**
*   **Category:** Repository
*   **Scenario:** Deterministic Tie-Breaking.
*   **Preconditions:** Datasource returns two Standard projects with the *exact same* `publishedAt` time. 1. ID: "B_Project", 2. ID: "A_Project".
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** "A_Project" appears before "B_Project" (Sorted alphabetically by ID).
*   **Traceability:** Repository Step 6 (Tie-Breaker), Edge Case: Unstable Sort.

**Test Case ID: REP-007**
*   **Category:** Repository
*   **Scenario:** Pagination (Standard Slice).
*   **Preconditions:** Repository has 10 filtered projects. Caller requests `page: 2`, `limit: 3`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Returns items at indices 3, 4, and 5 (The second batch of 3).
*   **Traceability:** Repository Step 7.

**Test Case ID: REP-008**
*   **Category:** Repository
*   **Scenario:** Pagination Out of Bounds.
*   **Preconditions:** Repository has 5 filtered projects. Caller requests `page: 2`, `limit: 10`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Returns an empty list `[]`.
*   **Traceability:** Repository Step 7, Edge Case: Pagination Out of Bounds.

**Test Case ID: REP-009**
*   **Category:** Repository
*   **Scenario:** Datasource Failure Mapping.
*   **Preconditions:** Datasource throws `DataParsingException`.
*   **Action:** Call `getProjects`.
*   **Expected Outcome:** Returns `Left(DataParsingFailure)`.
*   **Traceability:** Method Responsibility (Map failures).

## 6. Full Working Flow (Datasource → Repository)

**Step 1:** The UI requests `getProjects(page: 1, filter: "flutter")`.
**Step 2:** The Repository sanitizes the inputs and asks the Datasource for *all* projects.
**Step 3:** The Datasource reads the JSON file, discards any corrupt records (logging them), and returns a list of valid `Project` entities.
**Step 4:** The Repository receives the list and filters out "Hidden" projects.
**Step 5:** The Repository keeps only projects containing the "flutter" technology tag.
**Step 6:** The Repository sorts the remaining list: Hero projects first, then by date.
**Step 7:** The Repository slices the first 6 items (Page 1) from the sorted list.
**Step 8:** The Repository returns the final list to the UI.

## 7. Notes

*   **Missing Feature:** The `ProjectFilter` entity currently lacks `isFeatured`. Logic for this is explicitly omitted until the Entity is updated.
*   **Performance:** While acceptable for now, if the project list grows > 1000 items, the in-memory sorting strategy will need to move to an Isar/SQLite database.

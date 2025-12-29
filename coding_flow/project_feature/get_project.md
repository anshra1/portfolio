# Project Feature Name
Projects

# Method Name
`getProjects`

# Method Responsibility
*   Retrieve the full list of projects from the data source.
*   Filter projects based on search queries (title, tagline, description).
*   Filter projects based on technology tags.
*   Sort projects by Display Tier (Hero > Showcase > Standard) and Publication Date.
*   Paginate the results based on requested page and limit.
*   Map data models to domain entities.
*   Handle errors and return a `Failure` or `List<Project>`.

# Datasource (The Mechanism)

## Full Method Working (Plain English)
*   **Action:** Fetches raw project data from the remote provider.
*   **Behavior:** Accepts pagination and filter parameters, returning a list of `ProjectModel` objects.

## Context & Inputs
*   **Data:** `page` (int), `filter` (ProjectFilterModel), `limit` (int?)

## Edge Cases
*   Network errors.
*   Server errors.

## Architectural Decisions
*   Returns raw `ProjectModel` objects.

## Test Cases
*   Verify successful data fetching.
*   Verify error propagation.

# Repository (The Policy)

## Full Method Working (Plain English)
1.  **Fetch Complete Dataset:** The repository calls the `ProjectsRemoteDataSource.getProjects` method with fixed parameters (`page: 1`, `limit: 1000`) to retrieve all available projects. This ignores the user's pagination arguments at this stage to enable client-side processing.
2.  **Transform to Entities:** The returned `ProjectModel` list is mapped to `Project` entities.
3.  **Apply Search Filter:** If `filter.searchQuery` is provided, the list is filtered to include only projects where the `title`, `tagline`, or `description` contains the query string (case-insensitive).
4.  **Apply Technology Filter:** If `filter.technology` is provided, the list is filtered to include only projects that have the specified technology in their `technologies` list (case-insensitive).
5.  **Apply Ranked Sorting:** The list is sorted using a composite strategy:
    *   **Primary Sort:** By `DisplayTier`. `Hero` tier comes first, followed by `Showcase`, then `Standard`.
    *   **Secondary Sort:** By `publishedAt` date. Defaults to newest first. If `filter.sortOrder` is `oldest`, sorts by oldest first.
6.  **Apply Pagination:**
    *   Calculates the `startIndex` based on `(page - 1) * limit`.
    *   Calculates the `endIndex`.
    *   If `startIndex` is beyond the list size, returns an empty list.
    *   Otherwise, returns the sublist from `startIndex` to `endIndex`.
7.  **Return:** Returns `Right(List<Project>)` on success.
8.  **Error Handling:** Catches any `Exception` thrown during the process, converts it to a `Failure` using `ErrorMapper`, and returns `Left(Failure)`.

## Context & Inputs
*   **Services:**
    *   `ProjectsRemoteDataSource`: To fetch the raw data.
    *   `ErrorMapper`: To map exceptions to failures.
*   **Data:**
    *   `page` (int): The requested page number.
    *   `filter` (ProjectFilter): Contains `searchQuery`, `technology`, and `sortOrder`.
    *   `limit` (int?): The number of items per page (defaults to 10 if null).

## Edge Cases
*   **Empty Dataset:** If datasource returns empty, repository returns empty.
*   **Pagination Out of Bounds:** If `page` implies a start index greater than the filtered result count, return an empty list.
*   **Filtering Results in Empty:** If search/tech filters match no items, return an empty list.
*   **Datasource Exception:** If the datasource throws, return `Left(Failure)`.

## Architectural Decisions
*   **Client-Side Logic Injection:** The repository explicitly requests *all* data (`limit: 1000`) from the datasource to perform filtering and sorting in memory. This is chosen to support complex sorting (Tier + Date) and responsive filtering without backend complexity, assuming the dataset size remains manageable.
*   **Tiered Sorting:** The business logic strictly prioritizes `DisplayTier` over Date to ensuring "Hero" projects always appear first.

## Test Cases
*   **Search Logic:** Verify that a search query excludes projects without matching title/tagline/description.
*   **Tech Logic:** Verify that a technology filter excludes projects without the tag.
*   **Sort Logic:** Verify that a mixed list returns with Hero > Showcase > Standard order.
*   **Pagination Logic:** Verify correct slicing for Page 1 vs Page 2. Verify Page 99 returns empty.
*   **Transformation:** Verify models are correctly mapped to entities.

# Full Working Flow (Datasource → Repository)

1.  **Repository** receives a request for `getProjects(page, filter)`.
2.  **Repository** calls `Datasource.getProjects` requesting page 1 and limit 1000 (all data).
3.  **Datasource** returns a list of raw `ProjectModel`s.
4.  **Repository** converts Models to Entities.
5.  **Repository** filters the list by search query and technology.
6.  **Repository** sorts the list by Tier and Date.
7.  **Repository** slices the list based on the requested `page`.
8.  **Repository** returns the final list of `Project` entities to the Use Case.

# Project Feature Name
Projects

# Method Name
`getProjects`

# Method Responsibility
*   Retrieve a complete list of projects from the remote datasource.
*   Orchestrate client-side filtering by search query (title, tagline, description).
*   Orchestrate client-side filtering by technology tags.
*   Orchestrate client-side sorting by Display Tier (Hero > Showcase > Standard) and Publication Date.
*   Orchestrate client-side pagination.
*   Map raw data models to domain entities.
*   Handle exceptions and map them to domain failures.

# Datasource (The Mechanism)

## Full Method Working (Plain English)
**Step 1:** The method receives the requested page number, the filtering criteria, and the desired limit.

**Step 2:** It accesses the application's internal asset bundle to locate the static data file.

**Step 3:** It loads the content of the local JSON file as a string.

**Step 4:** It decodes this string into a list of raw `ProjectModel` objects.
*   **Step 4a (Success):** It returns the list of models.
*   **Step 4b (Failure):** It throws a specific exception if the file is missing or the JSON is invalid.

## Context & Inputs
**Services:**
*   `AssetBundle`: To load the local file from the application binary (e.g., `rootBundle`).

**Data:**
*   `assetPath`: The specific file path string to the JSON asset (e.g., `assets/data/projects.json`).
*   `page`: Page number (context only).
*   `limit`: Limit (context only).

## Edge Cases
*   **Asset Missing:** The specified file path does not exist in the bundle.
*   **Malformed JSON:** The file content is not valid JSON or does not match the expected schema.

## Architectural Decisions
*   **Static Site Architecture:** As defined in the Tech Stack, this is a static website without a backend. All data is shipped with the application as static assets.
*   **Raw Data Return:** The Datasource parses the static file into raw Models. It performs no filtering or sorting; that remains the Repository's job.

## Test Cases
*   **TC01:** Given a valid JSON asset, when loaded, then return a list of `ProjectModel`.
*   **TC02:** Given a malformed JSON file, when loaded, then throw a `FormatException`.

# Repository (The Policy)

## Full Method Working (Plain English)
**Step 1:** The repository receives a request for projects including the page number, filtering options, and page size.

**Step 2:** It asks the Datasource for the entire library of projects.
*   **Constraint:** It deliberately requests everything at once, ignoring the user's specific page for a moment, to ensure it has all data available for sorting and filtering in memory.

**Step 3:** It waits for the Datasource to respond.
*   **Step 3a (Success):** It proceeds to the next step with the raw data.
*   **Step 3b (Failure):** It captures the error, translates it into a standard business failure format, and returns that failure immediately.

**Step 4:** It transforms the raw data records into domain-specific Project objects.

**Step 5:** It checks if the user provided a search query.
*   **Step 5a (Query Exists):** It narrows the list down to only projects where the title, tagline, or description matches the search text.
*   **Step 5b (No Query):** It leaves the list unchanged.

**Step 6:** It checks if the user selected a specific technology filter.
*   **Step 6a (Tech Exists):** It keeps only the projects that use that specific technology.
*   **Step 6b (No Tech):** It leaves the list unchanged.

**Step 7:** It organizes the remaining projects into the correct order.
*   **Primary Rule:** It places "Hero" projects at the very top, followed by "Showcase" projects, and then "Standard" projects.
*   **Secondary Rule:** Within those groups, it sorts them by date (Newest to Oldest by default, or Oldest to Newest if requested).

**Step 8:** It calculates the correct page of results to show.
*   **Step 8a:** It determines the starting position based on the current page number and page size.
*   **Step 8b:** It checks if this starting position is valid. If the start point is beyond the number of available projects, it returns an empty list.
*   **Step 8c:** It slices out just the specific items needed for the requested page.

**Step 9:** It returns the final, processed list of projects.

## Context & Inputs
**Services:**
*   `ProjectsRemoteDataSource`: To fetch the raw data.

**Data:**
*   `page`: Requested page number.
*   `filter`: Contains `searchQuery`, `technology`, and `sortOrder`.
*   `limit`: Page size (default 10).

## Edge Cases
*   **Empty API Response:** Datasource returns empty list -> Repository returns empty list.
*   **Pagination Overflow:** Requesting Page 10 of a 5-page result set returns an empty list.
*   **Filtering Exhaustion:** Search query matches zero items -> Returns empty list.

## Architectural Decisions
*   **Logic Injection:** The repository assumes full responsibility for filtering and sorting. This decision decouples the specific sorting/filtering capabilities of the backend from the frontend requirements, ensuring the "Hero" tier logic is strictly enforced regardless of backend implementation.

## Test Cases
*   **TC01:** Given a list of mixed-tier projects, when fetched, verify they are sorted Hero > Showcase > Standard.
*   **TC02:** Given a search query "Flutter", verify only projects with "Flutter" in title/desc are returned.
*   **TC03:** Given a request for Page 2 with limit 2, verify items 3 and 4 are returned.
*   **TC04:** Given a datasource exception, verify a `Left(Failure)` is returned.

# Full Working Flow (Datasource → Repository)

**Step 1:** The Use Case calls `repository.getProjects(page: 1, filter: search="App")`.

**Step 2:** The Repository calls `datasource.getProjects(page: 1, limit: 1000)`.

**Step 3:** The Datasource loads the static JSON file from assets, parses it, and returns a `List<ProjectModel>` (e.g., 20 items).

**Step 4:** The Repository converts these 20 models to entities.

**Step 5:** The Repository filters the 20 entities. "App" is found in 5 projects. List size is now 5.

**Step 6:** The Repository sorts the 5 projects. 1 Hero project moves to index 0.

**Step 7:** The Repository applies pagination (Page 1, Limit 10). It takes items 0-5.

**Step 8:** The Repository returns `Right([Project1, Project2, ...])` to the Use Case.

# Notes
*   **Assumption:** The total number of projects will remain small enough (< 1000) that fetching all of them and filtering in memory is performant. If the dataset grows significantly, this logic must move to the backend/datasource.

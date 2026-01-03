# Plain-English Method Design Shell: getProjectDetail

## 1. Project Feature Name

**Projects Feature**

**Role:**
Allows users to discover, filter, and view the portfolio's body of work. This method enables deep inspection of a single project's details.

## 2. Method Name

`getProjectDetail`

**Role:**
A specialized data recovery method that retrieves the full technical representation of a specific project by its ID. It is primarily used to restore application state during deep linking or browser refreshes.

## 3. Method Responsibility

**Role:**
Defines exactly what the method is accountable for.

*   **Retrieve** a specific project record from the local data store using its unique identifier.
*   **Validate** the input identifier.
*   **Map** technical I/O exceptions (Missing File, Malformed JSON, Not Found, Partial Data) to Domain Failures.
*   **Normalize** the data to ensure optional collections (downloads, features) are safe for UI consumption (never null).

## 4. Datasource (The Mechanism)

**Focus:** Pure IO interaction, JSON Parsing, Record Lookup, and Strict Serialization.

### 4.1 Full Method Working (Plain English)

**Step 1:** Check if the projects list is already cached in memory.
   *   **1a (Cached):** Use the existing list.
   *   **1b (Not Cached):** Load `assets/data/projects.json`, parse it, skip corrupt records (Valid-Subset Recovery), and cache the result.
**Step 2:** Search the list for the first `ProjectModel` where `id` matches `projectId`.
   *   **2a (Found):** Return the `ProjectModel`.
   *   **2b (Not Found):** Throw `NotFoundException`.
       *   *Note:* If a project exists in the file but is corrupt (missing mandatory fields), it was skipped during Step 1. Therefore, it will effectively be treated as "Not Found" here.

### 4.2 Context & Inputs

**Services:**
*   `AssetBundle` (or `rootBundle`): To read the file.

**Data:**
*   File Path: `assets/data/projects.json`.
*   Input: `String projectId`.



### 4.3 Architectural Decisions

*   **In-Memory Caching:** Reuses the cached list from `getProjects` to avoid redundant parsing.
*   **Relaxed Contract:** We treat corrupt records as "Not Found" rather than throwing a parsing error. This ensures that a single bad record doesn't prevent looking up other valid records.
*   **Datasource Lookup:** The responsibility of iterating the list is delegated to the Datasource.



## 5. Repository (The Policy)

**Focus:** Coordination, Validation, Error Translation, and Data Normalization.

### 5.1 Full Method Working (Plain English)

**Step 1:** **Validate Input:**
   *   Check if `projectId` is empty or null.
   *   If invalid, return `Left(ValidationFailure)`.

**Step 2:** **Fetch Data:**
   *   Call the Datasource's `getProjectDetail(projectId)` method.
   *   *Concurrency Note:* Standard platform async handling is used; no explicit debounce logic is applied.

**Step 3:** **Handle Exceptions (Try/Catch):**
   *   Catch `NotFoundException` → Return `Left(NotFoundFailure)`.
   *   Catch `DataParsingException` → Return `Left(DataParsingFailure)`.
   *   Catch generic `Exception` → Return `Left(UnknownFailure)`.

**Step 4:** **Normalize & Return:**
   *   Receive the `ProjectModel`.
   *   Convert it to a `Project` entity using `.toEntity()`.
   *   *Normalization Rule:* Ensure that if `downloads` or `features` lists are null in the model, they are converted to empty lists `[]` in the entity.
   *   Return `Right(Project)`.

### 5.2 Context & Inputs

**Services:**
*   `ProjectsRemoteDataSource`: To perform the actual lookup.

**Data:**
*   Input: `String projectId`.


### 5.3 Architectural Decisions

*   **Strict Error Mapping:** The Repository converts technical exceptions into semantic domain failures (`NotFoundFailure`) for the UI.
*   **Deep Link Recovery:** This method is explicitly designed for "cold start" scenarios.


## 6. Full Working Flow (Datasource → Repository)

**Step 1:** The UI (Page or Bloc) detects a missing project object (e.g., from a deep link) and calls `repository.getProjectDetail("p1")`.
**Step 2:** The Repository validates the ID "p1".
**Step 3:** The Repository delegates the call to the Datasource.
**Step 4:** The Datasource reads the JSON file, parses it, finds the record with ID "p1", validates its schema (strict check), and returns the `ProjectModel`.
**Step 5:** The Repository catches any errors (mapping "Not Found" if necessary).
**Step 6:** The Repository converts the Model to an Entity, ensuring all lists are safe (non-null).
**Step 7:** The Repository returns `Right(Project)` to the UI for display.

## 7. Notes

*   **Performance:** Loading and parsing the entire JSON file for a single lookup is acceptable given the small dataset size (Portfolio scale).
*   **Navigation Optimization:** Standard navigation from the list view should bypass this method and pass the existing `Project` object directly to avoid this I/O overhead.

8. Clarfying question resolved :
9. Gap Detection & Missing Details
10. assumptions made:
*   
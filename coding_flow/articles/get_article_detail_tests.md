# Test Specification: getArticleDetail

## 1. Datasource Test Cases (Mechanism-Level)

**Test Case ID: DS-ART-DET-001**
*   **Category:** Datasource
*   **Scenario:** Cold start retrieval (Cache Miss).
*   **Preconditions:** In-memory cache is empty. `articles.json` exists and is valid. Target article "a1" exists with valid content file.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Registry is read/parsed. Returns `ArticleModel` with populated content string. Cache is populated.
*   **Traceability:** Step 1b (Load Registry), Step 5 (Hydrate).

**Test Case ID: DS-ART-DET-002**
*   **Category:** Datasource
*   **Scenario:** Cached retrieval (Cache Hit).
*   **Preconditions:** In-memory cache is already populated with parsed models.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** `articles.json` is **NOT** read again. Returns `ArticleModel` from cache, then hydrates content from file.
*   **Traceability:** Step 1a (Cache Check).

**Test Case ID: DS-ART-DET-003**
*   **Category:** Datasource
*   **Scenario:** Concurrent Initialization (Initialization Lock).
*   **Preconditions:** Cache is empty. Two separate callers invoke `getArticleDetail` simultaneously.
*   **Action:** Execute both calls in parallel.
*   **Expected Outcome:** `articles.json` is parsed exactly **once**. Both callers receive valid `ArticleModel`s.
*   **Traceability:** Step 1a (Init Lock), Edge Case EC-2.

**Test Case ID: DS-ART-DET-004**
*   **Category:** Datasource
*   **Scenario:** Target ID not found.
*   **Preconditions:** Registry is loaded but does not contain ID "unknown".
*   **Action:** Call `getArticleDetail("unknown")`.
*   **Expected Outcome:** Throws `NotFoundException` (Extends `AppException`).
*   **Traceability:** Step 2a.

**Test Case ID: DS-ART-DET-005**
*   **Category:** Datasource
*   **Scenario:** Partial Corruption (Missing Mandatory Field).
*   **Preconditions:** Registry contains ID "a1", but the record is missing `contentPath`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 2b (Target Validation), Edge Case EC-5.

**Test Case ID: DS-ART-DET-006**
*   **Category:** Datasource
*   **Scenario:** Path Traversal Attack (Relative Path).
*   **Preconditions:** Registry contains ID "a1" with `contentPath` set to `database/articles/content/../../secret.txt`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). Warning logged. File is **NOT** accessed.
*   **Traceability:** Step 3 (Security Validation), Edge Case EC-1.

**Test Case ID: DS-ART-DET-007**
*   **Category:** Datasource
*   **Scenario:** Path Traversal Attack (Invalid Prefix).
*   **Preconditions:** Registry contains ID "a1" with `contentPath` set to `lib/main.dart` (Valid path, wrong root).
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). File is **NOT** accessed.
*   **Traceability:** Step 3 (Security Validation), Edge Case EC-1.

**Test Case ID: DS-ART-DET-008**
*   **Category:** Datasource
*   **Scenario:** Oversized Content File.
*   **Preconditions:** Target content file at `contentPath` is physically 5.1 MB.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). Content is **NOT** decoded to string.
*   **Traceability:** Step 4a (Size Check), Edge Case EC-3.

**Test Case ID: DS-ART-DET-009**
*   **Category:** Datasource
*   **Scenario:** Non-UTF8 Content Encoding.
*   **Preconditions:** Target content file contains invalid binary sequences.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 4b (Strict Decoding), Edge Case EC-4.

**Test Case ID: DS-ART-DET-010**
*   **Category:** Datasource
*   **Scenario:** Orphaned Registry Entry (Missing Content File).
*   **Preconditions:** Registry entry valid, but file at `contentPath` does not exist.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 4 (Resource Read), Edge Case EC-6.

**Test Case ID: DS-ART-DET-011**
*   **Category:** Datasource
*   **Scenario:** Empty Content File (Valid Boundary).
*   **Preconditions:** Target content file exists but has 0 bytes.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `ArticleModel` where `content` is an empty string `""`. No exception is thrown.
*   **Traceability:** Section 4.3 (Edge Cases - Empty Content).

---

## 2. Repository Test Cases (Policy-Level)

**Test Case ID: REP-ART-DET-001**
*   **Category:** Repository
*   **Scenario:** Input Validation (Empty ID).
*   **Preconditions:** None.
*   **Action:** Call `getArticleDetail("")`.
*   **Expected Outcome:** Returns `Left(ValidationFailure)`. Datasource is **NOT** called.
*   **Traceability:** Step 1 (Validate Input).

**Test Case ID: REP-ART-DET-002**
*   **Category:** Repository
*   **Scenario:** Successful Success Path.
*   **Preconditions:** Datasource returns valid `ArticleModel` with content.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Right(Article)`. Entity ID matches input. Entity content matches model content.
*   **Traceability:** Step 2 (Fetch), Step 4 (Convert & Return).

**Test Case ID: REP-ART-DET-003**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Not Found.
*   **Preconditions:** Datasource throws `NotFoundException` (AppException).
*   **Action:** Call `getArticleDetail("unknown")`.
*   **Expected Outcome:** Returns `Left(NotFoundFailure)`. Uses `ErrorMapper` to convert exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.

**Test Case ID: REP-ART-DET-004**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Data Parsing (Security/Integrity/Schema).
*   **Preconditions:** Datasource throws `DataParsingException` (AppException).
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Left(DataParsingFailure)`. Uses `ErrorMapper` to convert exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.

**Test Case ID: REP-ART-DET-005**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Unknown Exception.
*   **Preconditions:** Datasource throws generic `Exception`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Left(UnknownFailure)`. Uses `ErrorMapper` to catch and map generic exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.
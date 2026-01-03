
  Improvements & Pitfalls (The Feedback)

  While the process is solid, here are 3 subtle improvements to make
  it "Battle-Ready":

  1. Add an "Edge Case Scan" to Step 2
   * Critique: Converting purpose to functional flow usually focuses
     on the "Happy Path" (success).
   * Improvement: Explicitly ask the AI to generate a "What could go
     wrong?" list during Step 2.
       * Example: "Flow: Fetch data. Check: What if data is null?
         What if page is 0? What if search query is empty string?"
       * Why: Tests for failures are often more important than tests
         for success.

  2. The "Mock Data Strategy" Decision (Step 3)
   * Critique: You define logic decisions, but often forget data
     decisions.
   * Improvement: In Step 3, explicitly decide "What mock data do I
     need to prove this?"
       * Example: "To test sorting, I need exactly 3 projects: One
         'Hero' from 2020, one 'Standard' from 2024, and one
         'Standard' from 2023."
       * Why: Writing tests becomes painful when you don't know what
         data to arrange. Deciding the data shape early makes
         writing setUp() trivial.

  3. The "Red-Green" Check (Step 4)
   * Critique: "Write test then write code" can sometimes lead to
     writing a test that always passes (false positive).
   * Improvement: Add a micro-step: "Ensure the test fails first."
       * Why: It proves that your test is actually testing
         something. If it passes before you write the real code,
         your test is broken.


I understand this workflow perfectly. It is a "Progressive
  Refinement" strategy for TDD. You are essentially building a
  bridge from "Human Intent" to "Machine Code" in four clear steps.

  Here is my understanding of your process:

  1. The Seed (User Intent)
  Input: You provide a simple 2-3 line statement.
   * Example: "I want getProjects to return a list of projects, but
     ensure the featured ones are at the top and it supports
     paging."
   * Role: This sets the Goal. It is the "What".

  2. The Expansion (AI Logic Draft)
  Action: I (the AI) convert that simple goal into a Functional Flow
  in plain English. I describe the logical steps required to achieve
  that goal (e.g., "First fetch data, then filter by X, then sort by
  Y...").
   * Role: This exposes hidden complexity. It turns the "What" into
     a rough "How".

  3. The Blueprint (Architectural Decisions)
  Action: We verify the flow against strict Architectural Decisions
  (e.g., "Sort must be Tier > Date", "Pagination must use slicing").
  We refine the plain English flow into a strict set of rules.
   * Role: This creates the Specification. It freezes the
     requirements so they don't change while coding.

  4. The Translation (Test List -> Code)
  Action:
       1. Convert the "Decisions" list into a Test List (e.g., "Test
          1: Returns empty list if page is out of bounds", "Test 2:
          Hero tier is index 0").
       2. Write the actual Test Code (flutter_test).
       3. Write the Real Code (repository_impl.dart) to pass the
          tests.
   * Role: This is the Execution. It guarantees the code matches the
     blueprint exactly.
# 📘 Flutter Knowledge Vault

This folder acts as a **living database** of engineering standards, patterns, and best practices for this project.
It is organized into 10 key domains to ensure scalability and consistency.

## 🗂️ The Shelves

1.  **[UI & UX](./01_ui_ux/index.md)** - Visuals, Layouts, Theming, A11y.
2.  **[State Management](./02_state_management/index.md)** - Riverpod/Bloc patterns.
3.  **[Data & Networking](./03_data_and_networking/index.md)** - API Client, Error Handling, Storage.
4.  **[Testing & QA](./04_testing_and_qa/index.md)** - Unit, Widget, Integration, Golden tests.
5.  **[Architecture & Patterns](./05_architecture_and_patterns/index.md)** - Clean Architecture, Folder Structure.
6.  **[Native Integration](./06_native_integration/index.md)** - Android/iOS configs, MethodChannels.
7.  **[DevOps & Deployment](./07_devops_and_deployment/index.md)** - CI/CD, Flavors, Publishing.
8.  **[Performance & Debugging](./08_performance_and_debugging/index.md)** - Optimization, DevTools, Profiling.
9.  **[Essential Packages](./09_essential_packages/index.md)** - Vetted 3rd-party libraries.
10. **[Learning Resources](./10_learning_resources/index.md)** - Summaries, Articles, Research.
11. **[Code Writing Rules](./11_code_writing_rules/index.md)** - Guidelines for clean and consistent code.

---

## ✍️ Rules of Writing (Documentation Standard)

To maintain a clean and searchable database, all contributors must follow the **"Trailer vs. Movie"** principle:

1.  **The `index.md` (The Trailer):**
    *   Every folder must have an `index.md`.
    *   It acts as a high-level overview or "trailer" for the domain.
    *   It **must not** contain deep technical details.
    *   It **must** contain a Table of Contents linking to specific deep-dive files.

2.  **Specific `.md` Files (The Movie):**
    *   Technical details, code snippets, and "deep knowledge" belong in their own focused files.
    *   Example: Use `naming_conventions.md` for details, not the `index.md`.

3.  **Formatting:**
    *   Use clear headers (H1, H2, H3).
    *   Keep code snippets concise and production-ready.
    *   Use emojis for visual grouping.

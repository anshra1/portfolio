# Guide: Using Mermaid.js with HTML

This guide documents the specific patterns required to successfully embed and render Mermaid diagrams directly within HTML files in this project.

## Context
We use HTML files (e.g., `docs/app_features/flowchart_visual.html`) to provide interactive, visual representations of our architecture documentation.

## The Challenge
Embedding Mermaid syntax directly inside a `<div class="mermaid">` tag can cause parsing errors because the browser's HTML parser processes the text *before* Mermaid.js gets to it.

Common pitfalls:
*   **The `>` symbol**: Browsers interpret this as the end of an HTML tag.
*   **Unquoted Strings**: Can lead to syntax errors in strict parsing modes.

## Rules for Success

### 1. ALWAYS Quote Node Labels
Wrap every text label in double quotes. This protects spaces and special characters.

*   ❌ **Bad:** `Node[Hero > Standard]`
*   ✅ **Good:** `Node["Hero > Standard"]`

### 2. Escape Special Characters
HTML entities must be used for characters that have meaning in HTML.

*   **Greater Than (`>`)**: Use `&gt;`
*   **Less Than (`<`)**: Use `&lt;`

*   ❌ **Bad:** `Rank["Priority > 5"]`
*   ✅ **Good:** `Rank["Priority &gt; 5"]`

### 3. Basic HTML Template
Use this template for new visual documentation files:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diagram Title</title>
    <!-- Import Mermaid -->
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        mermaid.initialize({ startOnLoad: true });
    </script>
</head>
<body>
    <div class="mermaid">
    graph TD
        A["Start"] --> B["Process Data"]
        B --> C["Result: A &gt; B"]
    </div>
</body>
</html>
```

## Troubleshooting
If a diagram fails to render ("Syntax error in text"):
1.  Check for unquoted text strings.
2.  Search for any bare `>` or `<` symbols inside the graph definition.
3.  Simplify complex subgraph connections if the error persists.

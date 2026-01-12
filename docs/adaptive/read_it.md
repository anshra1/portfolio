1. Text Scaling & Overflow
  On the web, users have full control over their viewing
  environment. They might use Ctrl + to zoom the entire page or
  change their browser's default font size from 16px to 24px for
  better readability.

  The Risk:
  In mobile development, developers often use fixed-height
  containers (e.g., SizedBox(height: 50)). If a user increases their
  font size:
   * Clipping: The text becomes larger than the container and gets
     cut off.
   * Overflow: You get the "Yellow and Black Tape" error (in
     Flutter) because the text pushes the boundaries of its parent.

  The Solution:
   * Avoid Fixed Heights: Let containers grow vertically based on
     their content (min-height is okay, height is risky).
   * Flexible Layouts: Use widgets like Flexible or Expanded so text
     can wrap to multiple lines without breaking the layout.
   * Relative Units: Use layout constraints that adapt to the
     viewport size.

  ---

  2. State Management & Data Persistence
  In a mobile app, when you switch between apps and come back, the
  app state is usually preserved by the OS. On the web, the Refresh
  Button is the "Great Equalizer"—it completely destroys the current
  JavaScript/Dart execution context and starts over.

  A. Browser Refresh (Persistence)
   * The Problem: If you store a user's login status or a "Search
     Query" only in a variable (like a Bloc or Provider), hitting F5
     (Refresh) resets that variable to its initial state. The user
     is suddenly logged out or loses their work.
   * The Solution: You must "sync" critical state to the browser's
     storage:
       * LocalStorage: Persistent even after the browser is closed.
         Good for Theme preferences or Auth tokens.
       * SessionStorage: Cleared when the tab is closed.
       * Cookies: Necessary if the backend needs to read the state
         (like session IDs).

  B. The Back Button (Routing)
   * The Problem: On mobile, "Back" usually means "pop the last
     screen off the stack." On the web, users use the browser's
     physical back button. If your app doesn't use "Declarative
     Routing" (linking app state to the URL), clicking "Back" might
     take the user to a completely different website (the one they
     were on before they opened your app) instead of the previous
     page in your portfolio.
   * The Solution: Use a routing system (like go_router in Flutter)
     that synchronizes the Browser History API with your app's
     internal navigation stack.
       * Example: Navigating from /projects to /projects/1 should
         create a new entry in the browser history. Clicking "Back"
         should then correctly return the user to /projects.
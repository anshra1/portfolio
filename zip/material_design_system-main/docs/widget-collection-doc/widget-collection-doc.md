// ============================================================
// 🧱 WIDGETS INDEX
// ============================================================
// Centralized reference for all reusable UI widgets used in the app.
//
// Each entry defines:
// - Widget Name
// - Purpose (Short description)
// - When To Use (Context or guideline)
// - Location (File path)
//
// This file helps new developers or designers understand
// what reusable widgets are available and how to use them.
//
// ✅ Keep it concise, consistent, and well-commented.

Widget Folder Structure:

To keep our UI components organized and easy to find, we follow a clear folder structure within `lib/src/widgets/`.
Each subfolder groups related widgets, making it intuitive to navigate and understand where to create or locate specific UI elements.

```
lib/
└── src/
    └── widgets/
        ├── buttons/          // Buttons (Primary, Secondary, Tertiary, etc.)
        ├── cards/            // Card components
        ├── forms/            // Form input fields
        └── common/           // General-purpose widgets used across the app
```

### PrimaryButton
**Purpose:** Your go-to for the most important actions.
**When To Use:** Use this when you need users to take a primary action, like 'Save Changes,' 'Submit Order,' or 'Continue to Payment.'
**Location:** `lib/src/widgets/buttons/primary_button.dart`

### SecondaryButton
**Purpose:** For actions that are important, but not the absolute primary focus.
**When To Use:** Great for giving users alternative options like 'Cancel,' 'Go Back,' or 'Skip for Now.'
**Location:** `lib/src/widgets/buttons/secondary_button.dart`

### TertiaryButton
**Purpose:** Perfect for less critical actions, often appearing as simple text links.
**When To Use:** Use when the action is supplementary, like 'Learn More,' 'View Details,' or 'Retry.' (Currently, this widget is a placeholder and needs to be created.)
**Location:** // TODO: Find or create TertiaryButton
    

   
  
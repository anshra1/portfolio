# Core UI Kit: Button System Documentation

This document serves as the **source of truth** for using buttons within the application. It is optimized for both human developers and AI assistants to ensure consistency across the codebase.

## 1. Decision Tree: Which Button to Use?

Use this logic to select the correct component for any given user action.

| Priority | Context | Component | Example |
| :--- | :--- | :--- | :--- |
| **High** | The single most important action on the screen. | `KitPrimaryButton` | "Save", "Submit", "Buy Now" |
| **Medium** | Alternative actions, "Go Back", or secondary choices. | `KitSecondaryButton` | "Cancel", "Edit Profile" |
| **Low** | Filters, exports, or actions that need to sit quietly. | `KitOutlineButton` | "Export CSV", "Filter: Date" |
| **Lowest** | "Read more", "Skip", or un-emphasized actions. | `KitGhostButton` | "Skip for now", "Dismiss" |
| **Danger** | Any action that destroys data or has negative consequences. | `KitDestructiveButton` | "Delete Account", "Sign Out" |
| **Icon** | Actions represented purely by a symbol (X, Gear, Back). | `KitIconButton` | Close Modal, Settings, Back Nav |
| **Link** | Inline text actions that flow with paragraphs. | `KitLinkButton` | "Forgot Password?", "Terms of Service" |
| **Auth** | Third-party authentication providers. | `KitSocialButton` | "Continue with Google" |

---

## 2. Component Reference

### KitPrimaryButton
Use for the main "Call to Action" (CTA). Only **one** per view/section is recommended.

```dart
KitPrimaryButton(
  onPressed: _submitForm, // Pass null to disable
  child: const Text('Create Account'),
)
```

### KitSecondaryButton
Use for actions that support the primary goal or allow the user to retreat.

```dart
KitSecondaryButton(
  onPressed: () => Navigator.pop(context),
  child: const Text('Cancel'),
)
```

### KitDestructiveButton
Use for irreversible or negative actions.
*   **Default:** Solid red background (High emphasis).
*   **Outlined:** Transparent red border (Lower emphasis).

```dart
// High Emphasis (Delete Account)
KitDestructiveButton(
  onPressed: _deleteAccount,
  child: const Text('Delete Account'),
)

// Low Emphasis (Remove Item from list)
KitDestructiveButton(
  outlined: true,
  onPressed: _removeItem,
  child: const Text('Remove'),
)
```

### KitIconButton
Wraps `IconButton` to enforce system padding and hover states.
*   **tooltip**: Mandatory for accessibility.

```dart
KitIconButton(
  icon: const Icon(Icons.close),
  tooltip: 'Close Window',
  onPressed: () => Navigator.pop(context),
)
```

### KitSocialButton
Pre-styled for auth providers. Handles branding guidelines automatically.

```dart
KitSocialButton(
  brand: SocialBrand.google,
  onPressed: _signInWithGoogle,
)
```

---

## 3. Layout & Responsiveness

The button system is **Intrinsic** by default (hugs content). **Do not** add width logic inside the button classes. Control layout via the parent.

### Standard Web (Intrinsic)
Buttons should sit naturally next to each other.

```dart
Row(
  children: [
    KitOutlineButton(onPressed: _cancel, child: const Text('Cancel')),
    const SizedBox(width: 16),
    KitPrimaryButton(onPressed: _save, child: const Text('Save')),
  ],
)
```

### Mobile / Full Width (Block)
To make a button span the full width of its container (common on mobile bottom bars), wrap it in `SizedBox` (finite parent) or `Expanded` (flex parent).

```dart
// Method A: In a finite container
SizedBox(
  width: double.infinity,
  child: KitPrimaryButton(onPressed: ..., child: const Text('Login')),
)

// Method B: In a Column/Row
Column(
  crossAxisAlignment: CrossAxisAlignment.stretch, // Forces children to fill width
  children: [
    KitPrimaryButton(onPressed: ..., child: const Text('Login')),
  ],
)
```

### Responsive Components
Use `ResponsiveLayoutBuilder` (from this package) if the button layout must change structure (e.g., Row on Desktop -> Column on Mobile).

```dart
ResponsiveLayoutBuilder(
  builder: (context, windowClass) {
    if (windowClass.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KitPrimaryButton(...),
          const SizedBox(height: 8),
          KitSecondaryButton(...),
        ],
      );
    }
    // Desktop
    return Row(children: [KitSecondaryButton(...), KitPrimaryButton(...)]);
  }
)
```

---

## 4. Theming & Customization

### ❌ Don't
*   Don't hardcode hex colors (e.g., `Color(0xFF0000FF)`).
*   Don't wrap buttons in `Container` just to add padding/margin. Use `SizedBox` for spacing.
*   Don't use `InkWell` or `GestureDetector` manually to build buttons.

### ✅ Do
*   Use `Theme.of(context).colorScheme` if you need custom colors.
*   Use the `fixedSize` property only when strict alignment is required.

```dart
// Custom Color Example (Use sparingly)
KitPrimaryButton(
  backgroundColor: Theme.of(context).colorScheme.tertiary,
  onPressed: ...,
  child: const Text('Special Action'),
)
```

# 🎬 Animations Deep Dive

**Primary Package:** [`flutter_animate`](https://pub.dev/packages/flutter_animate)
**Current Version:** `^4.5.2`

## 🚀 The Philosophy: Declarative vs. Imperative
Don't manage `AnimationControllers` manually. Use the extension-based approach provided by `flutter_animate` to keep code clean, readable, and memory-safe.

## 🛠️ The Syntax Cheatsheet
The core power lies in the `.animate()` extension. It turns 25 lines of boilerplate into a one-liner.

```dart
Text("Hello World").animate()
  .fade(duration: 500.ms)      // Effect 1
  .scale(delay: 500.ms)        // Effect 2 (runs after fade)
  .move(using: Curves.easeIn); // Inherits duration from previous
```

### Time Extensions
Use the `num` extensions for readable durations:
*   `2.seconds`
*   `0.1.minutes`
*   `300.ms`

## ⚡ Key Features to Master

### 1. Inheritance (The "Smart" Defaults)
Effects automatically inherit `duration`, `delay`, and `curve` from the effect before them unless specified.
*   **First effect:** Uses `Animate.defaultDuration` (default 300ms).
*   **Subsequent effects:** Inherit from the previous one.

### 2. Sequencing with `.then()`
Use `.then()` to establish a new timing baseline. This makes complex sequences easy to read.

```dart
Text("Hello").animate()
  .fadeIn(duration: 600.ms)
  .then(delay: 200.ms) // Wait 200ms AFTER fade finishes
  .slide()             // Runs after the wait
```

### 3. Staggered Lists
Animate entire columns or rows with a single interval using `AnimateList`.

```dart
Column(
  children: [Text("A"), Text("B"), Text("C")]
    .animate(interval: 400.ms) // Stagger each child by 400ms
    .fade(duration: 300.ms),
)
```

### 4. Shared Effects (Design System)
Create reusable effect lists for consistency across the app.

```dart
// Define once
static List<Effect> entryTransition = [
  FadeEffect(duration: 200.ms, curve: Curves.easeOut),
  ScaleEffect(begin: 0.8, curve: Curves.easeIn)
];

// Use everywhere
Text('Hello').animate(effects: entryTransition);
```

## 🎛️ Events & Logic

### Events (Lifecycle)
Access the internal controller via callbacks:
*   `onInit`: Controller created.
*   `onPlay`: Animation starts (after delay).
*   `onComplete`: Animation finishes.

```dart
Text("Pulsing").animate(
  onPlay: (controller) => controller.repeat(reverse: true)
).fade();
```

### Callbacks & Listeners
Trigger logic at specific points in the animation.

```dart
// Callback at a specific time
Text("Hi").animate().fade().callback(
  duration: 300.ms, 
  callback: (_) => print('Halfway there!')
);

// Listen to value changes (0.0 to 1.0)
Text("Hi").animate().fade().listen(
  callback: (value) => print('Opacity: $value')
);
```

## 🔌 Adapters (Scroll & State)
Drive animations via external factors instead of time.

### Reacting to State (The "Implicit" Way)
Like `AnimatedOpacity`, but for everything.

```dart
// Button scales when _isHovered changes
MyButton().animate(
  target: _isHovered ? 1 : 0 // 1 = End of animation, 0 = Start
).scale(end: 1.1);
```

### Scroll Adapter
Sync animation to scroll position.
```dart
myWidget.animate(
  adapter: ScrollAdapter(myScrollController)
).fade();
```

## 🧪 Testing & Debugging
*   **Hot Reload:** Set `Animate.restartOnHotReload = true;` in your `main()` or setup to see animations replay instantly during development.

## 💎 Pro Implementation Patterns
*   **Tactile Feedback:** When a user taps a button, it should react.
    ```dart
    ElevatedButton(
      onPressed: () {},
      child: Text('Save Data'),
    ).animate(key: UniqueKey()).scale(duration: 100.ms, end: 0.95);
    ```
*   **The "Pro" Shimmer:** Instantly upgrade loading states.
    ```dart
    Container(color: Colors.grey).animate(
      onPlay: (c) => c.repeat()
    ).shimmer(duration: 1500.ms);
    ```

---

## 📝 Specialized Text Animations
**Primary Package:** [animated_text_kit: ^4.3.0](https://pub.dev/packages/animated_text_kit)

For narrative-style text or high-impact typography, use this package instead of raw animations.

### 🛠️ Common Implementation
```dart
AnimatedTextKit(
  animatedTexts: [
    TypewriterAnimatedText('Design first, then code'),
    WavyAnimatedText('Build beautiful UIs'),
  ],
  repeatForever: true,
)
```

### ⚡ Available Effects
- **Typewriter / Typer:** For realistic text entry simulations.
- **Wavy / Bounce:** For playful, energetic headers.
- **Colorize:** For moving gradient text.
- **TextLiquidFill:** For high-end "filling" effects.

### 🎛️ Key Properties
- `totalRepeatCount`: How many times to loop (if not forever).
- `pause`: The duration to wait between text changes.
- `onTap`: Makes the text interactive.

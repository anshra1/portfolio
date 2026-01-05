# 📝 Specialized Text Animations

**Primary Package:** [`animated_text_kit: ^4.3.0`](https://pub.dev/packages/animated_text_kit)

For narrative-style text or high-impact typography, use this package instead of raw animations.

## 🛠️ Common Implementation
```dart
AnimatedTextKit(
  animatedTexts: [
    TypewriterAnimatedText('Design first, then code'),
    WavyAnimatedText('Build beautiful UIs'),
  ],
  repeatForever: true,
)
```

## ⚡ Available Effects
- **Typewriter / Typer:** For realistic text entry simulations.
- **Wavy / Bounce:** For playful, energetic headers.
- **Colorize:** For moving gradient text.
- **TextLiquidFill:** For high-end "filling" effects.

## 🎛️ Key Properties
- `totalRepeatCount`: How many times to loop (if not forever).
- `pause`: The duration to wait between text changes.
- `onTap`: Makes the text interactive.

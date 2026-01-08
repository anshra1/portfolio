# ⚓ Anchored Overlays with Composited Transforms

This guide explains how to create overlays that perfectly follow an anchor widget, even during scrolling or layout shifts.

## 🏗️ The Three-Part Pattern

To implement an anchored overlay, you need three synchronized parts.

### 1. The Link (The "Tow Bar")
Define a `LayerLink` in your `State` class. This object acts as the shared handle between the target and the follower.

```dart
final LayerLink _layerLink = LayerLink();
```

### 2. The Target (The "Hitch")
Wrap your anchor widget (the button or card) in a `CompositedTransformTarget`. This marks the coordinate space that the follower will use.

```dart
CompositedTransformTarget(
  link: _layerLink,
  child: ElevatedButton(
    onPressed: _toggleOverlay,
    child: const Text('Target Widget'),
  ),
)
```

### 3. The Follower (The "Trailer")
Inside your `OverlayEntry` builder, wrap your content in a `CompositedTransformFollower`. 

```dart
CompositedTransformFollower(
  link: _layerLink,
  showWhenUnlinked: false, // Hide if the target scrolls off screen
  offset: const Offset(0, 50), // Position relative to the Target
  child: Material(
    child: Text('I am following the target!'),
  ),
)
```

## 🚀 Full Implementation Example

Here is a complete, production-ready pattern for a toggleable anchored tooltip.

```dart
class AnchoredOverlayExample extends StatefulWidget {
  @override
  _AnchoredOverlayExampleState createState() => _AnchoredOverlayExampleState();
}

class _AnchoredOverlayExampleState extends State<AnchoredOverlayExample> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 45), // Shows 45px below the target
          child: _TooltipContent(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ActionButton(onPressed: _toggleOverlay),
    );
  }
}
```

## ⚠️ Critical Best Practices

1.  **`showWhenUnlinked: false`**: Always set this to `false`. If the user scrolls so far that the target widget is disposed of, the overlay should disappear rather than jumping to the top-left of the screen.
2.  **`Positioned` Constraints**: The `CompositedTransformFollower` does not provide size constraints. Wrap your follower's child in a `Positioned` (inside the `OverlayEntry`) or a `SizedBox` to give it a defined width/height.
3.  **Cleanup**: Always remove the `OverlayEntry` in the `dispose()` method of your widget to prevent memory leaks and "ghost" UI elements.
4.  **Target Size**: The `Follower`'s coordinate system (0,0) starts at the top-left of the `Target`. Use the `offset` parameter to shift it relative to that point.

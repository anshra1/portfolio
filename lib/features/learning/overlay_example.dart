import 'package:flutter/material.dart';

class OverlayLearningExample extends StatefulWidget {
  const OverlayLearningExample({super.key});

  @override
  State<OverlayLearningExample> createState() => _OverlayLearningExampleState();
}

class _OverlayLearningExampleState extends State<OverlayLearningExample> {
  // 1. The "Tow Bar" - links the Target and the Follower
  final LayerLink _layerLink = LayerLink();
  
  OverlayEntry? _overlayEntry;
  bool _isOverlayOpen = false;

  void _toggleOverlay() {
    if (_isOverlayOpen) {
      _closeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    // Insert the overlay into the Overlay stack
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOverlayOpen = true;
    });
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOverlayOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        // 3. The "Follower" - attaches to the link
        return Positioned(
          width: 200, // Constrain width if needed
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 50), // Offset relative to the Target (x, y)
            showWhenUnlinked: false, // Hide if the target is gone
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueAccent,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'I am the Overlay!',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Scroll the list behind me.\nI stick to the button!',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Composited Transform Example')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 50,
        itemBuilder: (context, index) {
          if (index == 15) {
            // This is our special item
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                // 2. The "Target" - marks the location we want to follow
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: ElevatedButton(
                    onPressed: _toggleOverlay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isOverlayOpen ? Colors.grey : Colors.blue,
                    ),
                    child: Text(_isOverlayOpen ? 'Close Overlay' : 'Click Me (Item #15)')),
                ),
              ),
            );
          }
          return Card(
            child: ListTile(
              title: Text('List Item $index'),
            ),
          );
        },
      ),
    );
  }
}

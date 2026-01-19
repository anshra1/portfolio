import 'package:core_ui_kit/core_ui_kit.dart'; // Assuming KitButtons are here
import 'package:flutter/material.dart';

class ViewMoreProjectsAction extends StatelessWidget {
  const ViewMoreProjectsAction({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Using a custom styled button to match the specific design if KitButton doesn't match perfectly,
    // or wrapping a KitButton.
    // HTML: px-8 py-3 rounded-full bg-gray-200 dark:bg-gray-700 text-gray-800 ...
    // This looks like a secondary or outline button but with a specific background.
    // I'll use a raw implementation to match the HTML design exactly as per instructions "Prioritize Visual Excellence".

    return Padding(
      padding: const EdgeInsets.only(top: 16), // pt-4
      child: Center(
        child: SizedBox(
          height: 48,
          child: KitOutlineButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ), // px-8 py-3
            trailing: const Icon(Icons.arrow_forward, size: 20),
            child: const Text('Show More Projects'),
          ),
        ),
      ),
    );
  }
}

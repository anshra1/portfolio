import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class ViewAllLearningsAction extends StatelessWidget {
  const ViewAllLearningsAction({super.key});

  @override
  Widget build(BuildContext context) {
    // Replaced OutlinedButton with KitOutlineButton
    return Center(
      child: KitOutlineButton(
        onPressed: () {
          // TODO: Navigate to full Learnings page
          debugPrint('Navigate to all learnings');
        },
        trailing: const Icon(Icons.arrow_forward_rounded, size: 20),
        child: const Text('View All Learnings'),
      ),
    );
  }
}
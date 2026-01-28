import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class ReadInsightAction extends StatelessWidget {
  final String insightId;

  const ReadInsightAction({
    super.key,
    required this.insightId,
  });

  @override
  Widget build(BuildContext context) {
    // Replaced ElevatedButton with KitPrimaryButton
    return KitPrimaryButton(
      onPressed: () {
        // TODO: Trigger intent to open article drawer with insightId
        debugPrint('Open insight: $insightId');
      },
      trailing: const Icon(Icons.arrow_forward_rounded, size: 16),
      child: const Text('Read Insight'),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:portfolio/core/presentation/widgets/buttons/portfolio_outline_button.dart';

class ViewAllLearningsAction extends StatelessWidget {
  const ViewAllLearningsAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PortfolioOutlineButton(
        text: 'View All Learnings',
        icon: Icons.arrow_forward_rounded,
        onPressed: () {
          // TODO: Navigate to full Learnings page
          debugPrint('Navigate to all learnings');
        },
      ),
    );
  }
}

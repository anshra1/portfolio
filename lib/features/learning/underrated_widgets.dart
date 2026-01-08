import 'package:flutter/material.dart';

class UnderratedWidgetsExample extends StatefulWidget {
  const UnderratedWidgetsExample({super.key});

  @override
  State<UnderratedWidgetsExample> createState() => _UnderratedWidgetsExampleState();
}

class _UnderratedWidgetsExampleState extends State<UnderratedWidgetsExample> {
  bool _showLoader = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Underrated Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: '1. Baseline'),
            const Text('Align text or symbols perfectly on an invisible line.'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const BaselineExample(),
            ),

            const SizedBox(height: 30),
            const _SectionHeader(title: '2. Offstage'),
            const Text('Keeps the widget alive but hidden. No layout space, no painting.'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Show Loader'),
                    value: _showLoader,
                    onChanged: (value) {
                      setState(() {
                        _showLoader = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Using Offstage
                  Offstage(
                    offstage: !_showLoader,
                    child: const CircularProgressIndicator(),
                  ),
                  // Just to show space is gone when offstage is true (if it was just hidden opacity it would take space)
                  const SizedBox(height: 20),
                  const Text('Below the Offstage widget'),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const _SectionHeader(title: '3. DecoratedBox'),
            const Text('Lighter than Container when you only need decoration.'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'I am lighter than Container',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const _SectionHeader(title: '4. PhysicalModel'),
            const Text('Real shadows, real elevation, clipping.'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const PhysicalModelExample(),
            ),
             const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class BaselineExample extends StatelessWidget {
  const BaselineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("With Padding (Misaligned)"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'x',
              style: TextStyle(fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: const Text(
                '2',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20), 
        const Text("With Baseline (Aligned)"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline, // Important for Baseline widget to work in Row sometimes context dependent, but Baseline widget handles it itself usually.
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              'x',
              style: TextStyle(fontSize: 28),
            ),
            Baseline(
              baseline: 24, // Adjusted for the example font sizes
              baselineType: TextBaseline.alphabetic,
              child: const Text(
                '3',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PhysicalModelExample extends StatelessWidget {
  const PhysicalModelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Container with BoxShadow"),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black26,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Fake shadow. BoxShadow.'),
          ),
        ),
        const SizedBox(height: 30),
        const Text("PhysicalModel"),
        const SizedBox(height: 10),
        PhysicalModel(
          color: Colors.white,
          elevation: 8,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(16),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Real shadow. Real power.'),
          ),
        ),
      ],
    );
  }
}

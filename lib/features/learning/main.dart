import 'package:flutter/material.dart';
import 'overlay_example.dart';
import 'underrated_widgets.dart';

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LearningHomePage(),
    );
  }
}

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Examples'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Overlay Example'),
            subtitle: const Text('Demonstrates usage of Overlays'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OverlayLearningExample(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Underrated Widgets'),
            subtitle: const Text('Baseline, Offstage, DecoratedBox, PhysicalModel'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UnderratedWidgetsExample(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

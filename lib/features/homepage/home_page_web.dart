import 'package:flutter/material.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Home')),
      body: const Center(
        child: Text('Web / Desktop Layout'),
      ),
    );
  }
}

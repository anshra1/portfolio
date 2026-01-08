import 'package:flutter/material.dart';

class CoreSwitch extends StatelessWidget {
  const CoreSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(value: true, onChanged: (_) {});
  }
}

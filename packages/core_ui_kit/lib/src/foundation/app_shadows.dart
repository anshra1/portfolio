import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> sm = [
    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
  ];
  static const List<BoxShadow> md = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> lg = [
    BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 8)),
  ];
}

import 'package:flutter/foundation.dart';

@immutable
class InsightViewModel {
  final String id;
  final String imageUrl;
  final String title;
  final String date;
  final String readTime;
  final List<String> tags;
  final String description;

  const InsightViewModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.readTime,
    required this.tags,
    required this.description,
  });
}

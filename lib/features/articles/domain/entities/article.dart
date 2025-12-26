import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.isFeatured,
    required this.title,
    required this.publishDate,
    required this.readTime,
    required this.summary,
    required this.tags,
    required this.coverImageAsset,
  });

  final String id;
  final bool isFeatured;
  final String title;
  final DateTime publishDate;
  final String readTime;
  final String summary;
  final List<String> tags;
  final String coverImageAsset;

  @override
  List<Object?> get props => [
        id,
        isFeatured,
        title,
        publishDate,
        readTime,
        summary,
        tags,
        coverImageAsset,
      ];
}

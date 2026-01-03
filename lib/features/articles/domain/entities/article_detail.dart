import 'package:equatable/equatable.dart';

class ArticleDetail extends Equatable {
  const ArticleDetail({
    required this.id,
    required this.isFeatured,
    required this.title,
    required this.publishDate,
    required this.readTime,
    required this.summary,
    required this.tags,
    required this.coverImageAsset,
    required this.contentBody,
  });

  final String id;
  final bool isFeatured;
  final String title;
  final DateTime publishDate;
  final String readTime;
  final String summary;
  final List<String> tags;
  final String coverImageAsset;
  final String contentBody;

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
        contentBody,
      ];
}

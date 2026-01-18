class ArticleVM {
  final String title;
  final String date;
  final String readTime;
  final String imageUrl;
  final List<String> hashtags;

  const ArticleVM({
    required this.title,
    required this.date,
    required this.readTime,
    required this.imageUrl,
    required this.hashtags,
  });
}

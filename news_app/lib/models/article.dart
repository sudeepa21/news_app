class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String publishedAt;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description:
          json['description'] ?? 'No Description', // Default description
      imageUrl: json['urlToImage'] ?? '', //
      publishedAt:
          json['publishedAt'] ?? 'Unknown Date', // Default to "Unknown Date"
      content: json['content'] ?? 'Content unavailable', // Default content
    );
  }
}

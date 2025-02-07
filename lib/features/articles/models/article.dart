class ArticleSource {
  final String? id;
  final String name;

  ArticleSource({
    this.id,
    required this.name,
  });

  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final ArticleSource source;
  final String? author;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    this.author,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      source: json['source'] != null
          ? ArticleSource.fromJson(json['source'])
          : ArticleSource(name: ''),
      author: json['author'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'source': source.toJson(),
      'author': author,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
    };
  }
}

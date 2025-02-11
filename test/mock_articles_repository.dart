import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';

class MockArticlesRepository implements ArticlesRepository {
  List<Article> savedArticles = [];
  bool shouldThrowErrorOnGetSavedArticles = false;
  bool shouldThrowErrorOnDeleteArticle = false;

  @override
  Future<void> deleteArticle(String id) async {
    if (shouldThrowErrorOnDeleteArticle) {
      throw Exception('Failed to delete article from repository');
    }
    savedArticles.removeWhere((article) => article.url == id);
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    if (shouldThrowErrorOnGetSavedArticles) {
      throw Exception('Failed to load articles from repository');
    }
    return savedArticles;
  }

  @override
  Future<void> saveArticle(Article article) async {
    savedArticles.add(article);
  }
}

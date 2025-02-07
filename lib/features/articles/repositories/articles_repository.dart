import '../models/article.dart';

abstract interface class ArticlesRepository {
  Future<void> saveArticle(Article article);
  Future<void> deleteArticle(String id);
  Future<List<Article>> getSavedArticles();
}

import '../../models/article.dart';
import '../articles_repository.dart';

class CachedArticlesRepository implements ArticlesRepository {
  final ArticlesRepository _internalRepository;
  final Map<String, List<Article>> _cache = {};

  static const String _savedArticlesCacheKey = 'saved_articles_cache_key';

  CachedArticlesRepository(this._internalRepository);

  @override
  Future<List<Article>> getSavedArticles() async {
    if (_cache.containsKey(_savedArticlesCacheKey)) {
      return _cache[_savedArticlesCacheKey]!;
    }

    final articles = await _internalRepository.getSavedArticles();
    _cache[_savedArticlesCacheKey] = articles;
    return articles;
  }

  @override
  Future<void> saveArticle(Article article) async {
    await _internalRepository.saveArticle(article);
    _invalidateCache();
  }

  @override
  Future<void> deleteArticle(String id) async {
    await _internalRepository.deleteArticle(id);
    _invalidateCache();
  }

  void _invalidateCache() {
    _cache.clear();
  }
}

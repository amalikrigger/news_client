import '../models/article.dart';
import '../models/source.dart';

abstract interface class NewsService {
  Future<List<Source>> fetchSources();
  Future<List<Article>> fetchArticles({
    required String sourceId,
    required int pageSize,
    required int page,
    required String sortBy,
    String? query,
    DateTime? from,
    DateTime? to,
  });
}

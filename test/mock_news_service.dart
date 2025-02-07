import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/news_service.dart';

class MockNewsService implements NewsService {
  List<List<Article>> articlesToReturnSequences;
  int callCount = 0;
  List<Map<String, dynamic>> fetchArticlesCalls = [];

  MockNewsService({required this.articlesToReturnSequences});

  @override
  Future<List<Source>> fetchSources() async => [];

  @override
  Future<List<Article>> fetchArticles({
    required String sourceId,
    required int pageSize,
    required int page,
    required String sortBy,
    String? query,
    DateTime? from,
    DateTime? to,
  }) async {
    fetchArticlesCalls.add({
      'sourceId': sourceId,
      'pageSize': pageSize,
      'page': page,
      'sortBy': sortBy,
      'query': query,
      'from': from,
      'to': to,
    });
    if (callCount < articlesToReturnSequences.length) {
      return articlesToReturnSequences[callCount++];
    }
    return [];
  }
}

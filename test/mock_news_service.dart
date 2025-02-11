import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/news_service.dart';

class MockNewsService implements NewsService {
  List<List<Article>> articlesToReturnSequences;
  int articleCallCount = 0;
  List<Map<String, dynamic>> fetchArticlesCalls = [];

  List<Source>? sourcesToReturn;
  Exception? errorToThrow;

  MockNewsService({
    this.articlesToReturnSequences = const [],
    this.sourcesToReturn,
    this.errorToThrow,
  });

  @override
  Future<List<Source>> fetchSources() async {
    if (errorToThrow != null) {
      throw errorToThrow!;
    }
    return sourcesToReturn ?? [];
  }

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
    if (articleCallCount < articlesToReturnSequences.length) {
      return articlesToReturnSequences[articleCallCount++];
    }
    return [];
  }
}

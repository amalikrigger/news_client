import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/news_service.dart';
import 'package:news_client/features/articles/view_models/sources_view_model.dart';

class MockNewsService implements NewsService {
  List<Source>? sourcesToReturn;
  Exception? errorToThrow;

  MockNewsService({this.sourcesToReturn, this.errorToThrow});

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
    throw UnimplementedError();
  }
}

void main() {
  group('SourcesViewModel', () {
    test('Initial state is correct', () {
      final mockNewsService = MockNewsService();
      final viewModel = SourcesViewModel(newsApiService: mockNewsService);
      expect(viewModel.sources, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
    });

    test('loadSources sets isLoading to true initially', () async {
      final mockNewsService = MockNewsService(sourcesToReturn: []);
      final viewModel = SourcesViewModel(newsApiService: mockNewsService);
      final future = viewModel.loadSources();
      expect(viewModel.isLoading, isTrue);
      await future;
    });

    test('loadSources successfully loads sources', () async {
      // Arrange
      final expectedSources = [
        Source(
          id: 'abc-news',
          name: 'ABC News',
          description: 'Test description 1',
          url: 'https://abcnews.go.com',
          category: 'general',
          language: 'en',
          country: 'us',
        ),
        Source(
          id: 'bbc-news',
          name: 'BBC News',
          description: 'Test description 2',
          url: 'https://bbc.co.uk/news',
          category: 'general',
          language: 'en',
          country: 'gb',
        ),
      ];
      final mockNewsService = MockNewsService(sourcesToReturn: expectedSources);
      final viewModel = SourcesViewModel(newsApiService: mockNewsService);

      // Act
      await viewModel.loadSources();

      // Assert
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
      expect(viewModel.sources.length, expectedSources.length);
      for (int i = 0; i < expectedSources.length; i++) {
        final expectedSource = expectedSources[i];
        final actualSource = viewModel.sources[i];
        expect(actualSource.id, expectedSource.id,
            reason: 'Source at index $i: id mismatch');
        expect(actualSource.name, expectedSource.name,
            reason: 'Source at index $i: name mismatch');
        expect(actualSource.description, expectedSource.description,
            reason: 'Source at index $i: description mismatch');
        expect(actualSource.url, expectedSource.url,
            reason: 'Source at index $i: url mismatch');
        expect(actualSource.category, expectedSource.category,
            reason: 'Source at index $i: category mismatch');
        expect(actualSource.language, expectedSource.language,
            reason: 'Source at index $i: language mismatch');
        expect(actualSource.country, expectedSource.country,
            reason: 'Source at index $i: country mismatch');
      }
    });

    test('loadSources handles error when fetching sources', () async {
      // Arrange
      final errorMessage = 'Failed to fetch sources from API';
      final mockNewsService =
          MockNewsService(errorToThrow: Exception(errorMessage));
      final viewModel = SourcesViewModel(newsApiService: mockNewsService);

      // Act
      await viewModel.loadSources();

      // Assert
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.sources, isEmpty);
      expect(viewModel.error, isNotNull);
      expect(viewModel.error, contains(errorMessage));
    });

    test(
        'loadSources sets isLoading to false after completion, even with error',
        () async {
      // Arrange
      final mockNewsService =
          MockNewsService(errorToThrow: Exception('API Error'));
      final viewModel = SourcesViewModel(newsApiService: mockNewsService);

      // Act
      await viewModel.loadSources();

      // Assert
      expect(viewModel.isLoading, isFalse);
    });
  });
}

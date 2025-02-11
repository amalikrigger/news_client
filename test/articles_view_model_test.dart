import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/articles_refresh_service.dart';
import 'package:news_client/features/articles/view_models/articles_view_model.dart';

import 'mock_articles_repository.dart';
import 'mock_news_service.dart';

void main() {
  group('ArticlesViewModel Tests', () {
    late MockNewsService mockNewsService;
    late MockArticlesRepository mockArticlesRepository;
    late Source testSource;
    late ArticlesViewModel viewModel;
    late ArticlesRefreshService articlesRefreshService;

    setUp(() {
      mockNewsService = MockNewsService();
      mockArticlesRepository = MockArticlesRepository();
      testSource = Source(
        id: 'test-source-id',
        name: 'Test Source',
        description: 'Test Description',
        url: 'https://testsource.com',
        category: 'general',
        language: 'en',
        country: 'us',
      );
      articlesRefreshService = ArticlesRefreshService([],
          newsService: mockNewsService, sourceId: '');
      viewModel = ArticlesViewModel(
        newsApiService: mockNewsService,
        repository: mockArticlesRepository,
        source: testSource,
        articlesRefreshService: articlesRefreshService,
      );
    });

    Article createArticle({String? url}) {
      return Article(
        title: 'Test Article Title',
        description: 'Test Article Description',
        url: url ?? 'test-url',
        source: ArticleSource(id: 'test-source-id', name: 'Test Source'),
        author: 'Test Author',
        urlToImage: 'https://testimage.com/image.jpg',
        publishedAt: DateTime.now(),
        content: 'Test Article Content',
      );
    }

    tearDown(() {
      viewModel.dispose();
    });

    group('toggleSaveArticle', () {
      test('toggleSaveArticle - Save Article', () async {
        final articleToSave = createArticle();
        mockArticlesRepository.savedArticles = [];

        expect(viewModel.isSaved(articleToSave), false);

        await viewModel.toggleSaveArticle(articleToSave);

        expect(viewModel.isSaved(articleToSave), true);
        expect(
            mockArticlesRepository.savedArticles.contains(articleToSave), true);
      });

      test('toggleSaveArticle - Unsave Article', () async {
        final articleToUnsave = createArticle();
        mockArticlesRepository.savedArticles = [articleToUnsave];
        await viewModel.refreshSavedArticles();

        expect(viewModel.isSaved(articleToUnsave), true);

        await viewModel.toggleSaveArticle(articleToUnsave);

        expect(viewModel.isSaved(articleToUnsave), false);
        expect(mockArticlesRepository.savedArticles.contains(articleToUnsave),
            false);
      });
    });

    group('refreshSavedArticles', () {
      test('refreshSavedArticles - Success', () async {
        final savedArticlesFromRepo = [
          createArticle(url: 'saved-url-1'),
          createArticle(url: 'saved-url-2')
        ];
        mockArticlesRepository.savedArticles = savedArticlesFromRepo;

        expect(viewModel.isSaved(savedArticlesFromRepo[0]), false);
        expect(viewModel.isSaved(savedArticlesFromRepo[1]), false);

        await viewModel.refreshSavedArticles();

        expect(viewModel.isSaved(savedArticlesFromRepo[0]), true);
        expect(viewModel.isSaved(savedArticlesFromRepo[1]), true);
      });

      test('refreshSavedArticles - Repository Failure', () async {
        mockArticlesRepository.shouldThrowErrorOnGetSavedArticles = true;
        final savedArticlesInitially = [createArticle(url: 'saved-url-1')];
        mockArticlesRepository.savedArticles = savedArticlesInitially;
        await viewModel.refreshSavedArticles();
        expect(viewModel.isSaved(createArticle(url: 'saved-url-1')), false);
      });
    });

    group('isSaved', () {
      test('isSaved - Article is saved', () async {
        final savedArticle = createArticle(url: 'saved-article-url');
        mockArticlesRepository.savedArticles = [savedArticle];
        await viewModel.refreshSavedArticles();

        expect(viewModel.isSaved(savedArticle), true);
      });

      test('isSaved - Article is not saved', () {
        final notSavedArticle = createArticle(url: 'not-saved-article-url');
        mockArticlesRepository.savedArticles = [];
        viewModel.refreshSavedArticles();

        expect(viewModel.isSaved(notSavedArticle), false);
      });
    });
  });
}

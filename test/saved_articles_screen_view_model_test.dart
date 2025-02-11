import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/view_models/saved_articles_screen_view_model.dart';

import 'mock_articles_repository.dart';
import 'shared.dart';

void main() {
  group('SavedArticlesScreenViewModel', () {
    late MockArticlesRepository mockArticlesRepository;
    late SavedArticlesScreenViewModel viewModel;
    late List<Article> testArticles;

    setUp(() async {
      mockArticlesRepository = MockArticlesRepository();
      viewModel = SavedArticlesScreenViewModel(
          articlesRepository: mockArticlesRepository);
      testArticles = [
        Article(
          source: ArticleSource(id: 'bbc-news', name: 'BBC News'),
          author: null,
          title: '05/02/2025 20:01 GMT',
          description:
              'The latest five minute news bulletin from BBC World Service.',
          url: 'https://www.bbc.co.uk/programmes/w172zgfkxkxwsdn',
          urlToImage:
              'https://ichef.bbci.co.uk/images/ic/1200x675/p060dh18.jpg',
          publishedAt: DateTime.parse("2025-02-05T20:06:00Z"),
          content:
              'The latest five minute news bulletin from BBC World Service.',
        ),
        Article(
          source: ArticleSource(id: 'bbc-news', name: 'BBC News'),
          author: 'Bernd Debusmann Jr',
          title:
              'Trump signs order banning transgender women from female sports',
          description:
              'He says the move, which covers non-elite levels, restores fairness but human rights advocates have condemned it.',
          url: 'https://www.bbc.co.uk/news/articles/c20g85k3z35o',
          urlToImage:
              'https://ichef.bbci.co.uk/ace/branded_news/1200/cpsprodpb/f719/live/0d3abb90-e40f-11ef-a319-fb4e7360c4ec.jpg',
          publishedAt: DateTime.parse("2025-02-05T18:55:46Z"),
          content:
              'A number of sporting governing bodies, including swimming, athletics and golf, have banned transgender women from competing in the female category at elite level if they have gone through male pubert… [+2728 chars]',
        ),
      ];
      mockArticlesRepository.savedArticles = List.from(testArticles);
    });

    group('loadSavedArticles', () {
      test('success - loads articles and sets isLoading to false', () async {
        // Arrange
        mockArticlesRepository.shouldThrowErrorOnGetSavedArticles = false;

        // Act
        await viewModel.loadSavedArticles();

        // Assert
        expect(viewModel.isLoading, isFalse);
        compareArticleLists(viewModel.savedArticles, testArticles);
        expect(viewModel.errorMessage, isNull);
      });

      test(
          'failure - sets errorMessage and isLoading to false when repository fails',
          () async {
        // Arrange
        mockArticlesRepository.shouldThrowErrorOnGetSavedArticles = true;

        // Act
        await viewModel.loadSavedArticles();

        // Assert
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.savedArticles, isEmpty);
        expect(
            viewModel.errorMessage,
            equals(
                'Failed to load saved articles: Exception: Failed to load articles from repository'));
      });
    });

    group('deleteArticle', () {
      test('success - deletes article and updates savedArticles list',
          () async {
        // Arrange
        await viewModel.loadSavedArticles();
        mockArticlesRepository.shouldThrowErrorOnDeleteArticle = false;
        final initialArticleCount = viewModel.savedArticles.length;
        final articleToDeleteUrl = testArticles[0].url;
        final expectedArticlesAfterDeletion = testArticles.sublist(1);

        // Act
        await viewModel.deleteArticle(articleToDeleteUrl);

        // Assert
        expect(viewModel.errorMessage, isNull);
        expect(viewModel.savedArticles.length, initialArticleCount - 1);
        compareArticleLists(
            viewModel.savedArticles, expectedArticlesAfterDeletion);
        expect(
            viewModel.savedArticles
                .any((article) => article.url == articleToDeleteUrl),
            isFalse);
      });

      test('failure - sets errorMessage when repository fails to delete',
          () async {
        // Arrange
        await viewModel.loadSavedArticles();
        mockArticlesRepository.shouldThrowErrorOnDeleteArticle = true;
        final initialArticleCount = viewModel.savedArticles.length;
        final articleToDeleteUrl = testArticles[0].url;

        // Act
        await viewModel.deleteArticle(articleToDeleteUrl);

        // Assert
        expect(
            viewModel.errorMessage,
            equals(
                'Failed to delete article: Exception: Failed to delete article from repository'));
        expect(viewModel.savedArticles.length, initialArticleCount);
        expect(
            viewModel.savedArticles
                .any((article) => article.url == articleToDeleteUrl),
            isTrue);
      });
    });
  });
}

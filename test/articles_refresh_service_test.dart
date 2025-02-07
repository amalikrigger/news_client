import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/services/articles_refresh_service.dart';

import 'mock_news_service.dart';
import 'mock_start_stoppable_timer.dart';
import 'shared.dart';

void main() {
  group('ArticlesRefreshService Tests', () {
    test('Scenario 1 Initial Article Fetch Success', () async {
      final expectedArticles = [
        Article(
          title: 'Tech Breakthrough in AI',
          description:
              'Scientists announce a major advancement in artificial intelligence, promising faster processing and improved accuracy.',
          url: 'https://example.com/ai-breakthrough',
          source: ArticleSource(name: 'Tech News Daily', id: 'tech-daily'),
          author: 'Dr. Emily Carter',
          urlToImage: 'https://example.com/images/ai-image.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 2)),
          content: 'The new AI model, developed at...',
        ),
        Article(
          title: 'Stock Market Hits Record High',
          description:
              'The Dow Jones Industrial Average soared to a new all-time high, driven by strong earnings reports and positive economic data.',
          url: 'https://finance.example.com/stock-market-record',
          source: ArticleSource(name: 'Financial Times', id: 'ft'),
          author: 'John Smith',
          urlToImage: 'https://finance.example.com/images/stock-chart.png',
          publishedAt: DateTime.now().subtract(Duration(days: 1)),
          content: 'Investors cheered as the market...',
        ),
        Article(
          title: 'Local Community Celebrates Park Opening',
          description:
              'Residents gathered to celebrate the grand opening of the new community park, featuring playgrounds, walking trails, and picnic areas.',
          url: 'https://localnews.example.com/park-opening',
          source: ArticleSource(name: 'City Gazette', id: 'city-gazette'),
          author: 'Sarah Johnson',
          urlToImage: 'https://localnews.example.com/images/park-event.jpg',
          publishedAt: DateTime.now(),
          content: 'The park, years in the making...',
        ),
        Article(
          title: 'New Study Links Exercise to Better Sleep',
          description:
              'Research published in the Journal of Sleep Medicine suggests that regular exercise significantly improves sleep quality.',
          url: 'https://health.example.com/exercise-sleep-study',
          source: ArticleSource(
              name: 'Health & Wellness Magazine', id: 'health-mag'),
          author: 'Professor David Lee',
          urlToImage: 'https://health.example.com/images/sleep-exercise.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 3)),
          content: 'The study, involving over 500 participants...',
        ),
        Article(
          title: 'Space Agency Announces Mars Mission Update',
          description:
              'NASA provided an update on the ongoing Mars rover mission, highlighting new discoveries and the rover\'s continued exploration.',
          url: 'https://space.example.com/mars-mission-update',
          source:
              ArticleSource(name: 'Space Exploration News', id: 'space-news'),
          author: 'Mission Control',
          urlToImage: 'https://space.example.com/images/mars-rover.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 5)),
          content: 'The Perseverance rover has sent back...',
        ),
      ];
      final mockNewsService =
          MockNewsService(articlesToReturnSequences: [expectedArticles]);
      final mockTimer = MockStartStoppableTimer();
      final sourceId = 'test-source';

      final articlesRefreshService = ArticlesRefreshService(
        [],
        newsService: mockNewsService,
        sourceId: sourceId,
        timer: mockTimer,
      );

      await Future.delayed(Duration.zero);

      compareArticleLists(articlesRefreshService.value, expectedArticles);
      expect(mockNewsService.fetchArticlesCalls.length, 1);
      final fetchArticlesCallArgs = mockNewsService.fetchArticlesCalls.first;
      expect(fetchArticlesCallArgs['sourceId'], sourceId);
      expect(fetchArticlesCallArgs['pageSize'], 10);
      expect(fetchArticlesCallArgs['page'], 1);
      expect(fetchArticlesCallArgs['sortBy'], 'publishedAt');
      expect(fetchArticlesCallArgs['from'], null);
    });

    test('Scenario 2 Periodic Article Refresh Success', () async {
      final initialArticles = [
        Article(
            title: 'Initial Article 1',
            description: 'Desc 1',
            url: 'url1',
            source: ArticleSource(name: 'Source 1', id: null),
            publishedAt: DateTime.now().subtract(Duration(minutes: 10)),
            author: null,
            urlToImage: null,
            content: null),
      ];
      final refreshedArticles = [
        Article(
            title: 'Refreshed Article 1',
            description: 'New Desc 1',
            url: 'new_url1',
            source: ArticleSource(name: 'Source 1', id: null),
            publishedAt: DateTime.now(),
            author: null,
            urlToImage: null,
            content: null),
      ];
      final mockNewsService = MockNewsService(
          articlesToReturnSequences: [initialArticles, refreshedArticles]);
      final mockTimer = MockStartStoppableTimer();
      final sourceId = 'test-source';

      final articlesRefreshService = ArticlesRefreshService(
        [],
        newsService: mockNewsService,
        sourceId: sourceId,
        timer: mockTimer,
      );
      await Future.delayed(Duration.zero);
      mockTimer.triggerTimer();
      await Future.delayed(Duration.zero);

      compareArticleLists(articlesRefreshService.value, refreshedArticles);
      expect(mockNewsService.fetchArticlesCalls.length, 2);
      final secondCallArgs = mockNewsService.fetchArticlesCalls[1];
      expect(secondCallArgs['from'] != null, isTrue);
      expect(mockTimer.isTimerStarted, isTrue);
    });

    test('Scenario 3 No New Articles During Refresh', () async {
      final initialArticles = [
        Article(
            title: 'Initial Article 1',
            description: 'Desc 1',
            url: 'url1',
            source: ArticleSource(name: 'Source 1', id: null),
            publishedAt: DateTime.now().subtract(Duration(minutes: 10)),
            author: null,
            urlToImage: null,
            content: null),
      ];
      final mockNewsService =
          MockNewsService(articlesToReturnSequences: [initialArticles, []]);
      final mockTimer = MockStartStoppableTimer();
      final sourceId = 'test-source';

      final articlesRefreshService = ArticlesRefreshService(
        [],
        newsService: mockNewsService,
        sourceId: sourceId,
        timer: mockTimer,
      );
      await Future.delayed(Duration.zero);
      mockTimer.triggerTimer();
      await Future.delayed(Duration.zero);

      compareArticleLists(articlesRefreshService.value, []);
      expect(mockNewsService.fetchArticlesCalls.length, 2);
      final secondCallArgs = mockNewsService.fetchArticlesCalls[1];
      expect(secondCallArgs['from'] != null, isTrue);
      expect(mockTimer.isTimerStarted, isTrue);
    });
  });
}

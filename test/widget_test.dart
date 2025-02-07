import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';
import 'package:news_client/features/articles/services/implementations/news_api_service.dart';
import 'package:news_client/features/articles/view_models/sources_view_model.dart';
import 'package:news_client/features/articles/views/articles_screen.dart';
import 'package:news_client/features/articles/views/components/source_card.dart';
import 'package:news_client/features/articles/views/sources_screen.dart';
import 'package:provider/provider.dart';

class MockNewsApiService implements NewsApiService {
  List<Source> mockSources = [
    Source(
        id: 'cnn',
        name: 'CNN',
        description:
            'View the latest news and breaking news today for U.S., world, weather, entertainment, politics and health at CNN',
        url: 'http://cnn.com',
        category: 'general',
        language: 'en',
        country: 'us'),
    Source(
        id: 'bbc-news',
        name: 'BBC News',
        description:
            'Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News delivers trusted world and local news to audiences in the UK and around the world.',
        url: 'http://www.bbc.co.uk/news',
        category: 'general',
        language: 'en',
        country: 'gb'),
  ];

  bool shouldReturnError = false;

  MockNewsApiService({this.shouldReturnError = false});

  @override
  Future<List<Source>> fetchSources() async {
    if (shouldReturnError) {
      await Future.delayed(const Duration(milliseconds: 100));
      throw Exception('Failed to load sources');
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return mockSources;
  }

  @override
  void dispose() {}

  @override
  Future<List<Article>> fetchArticles(
      {required String sourceId,
      required int pageSize,
      required int page,
      required String sortBy,
      String? query,
      DateTime? from,
      DateTime? to}) {
    throw UnimplementedError();
  }
}

class MockArticlesRepository implements ArticlesRepository {
  @override
  Future<void> deleteArticle(String id) async {
    return Future.value();
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    return Future.value([]);
  }

  @override
  Future<void> saveArticle(Article article) async {
    return Future.value();
  }
}

void main() {
  group('SourcesScreen Widget Tests', () {
    testWidgets(
        'SourcesScreen shows loading indicator initially and then sources',
        (WidgetTester tester) async {
      final mockNewsApiService = MockNewsApiService();
      final mockArticlesRepository = MockArticlesRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) =>
                    SourcesViewModel(newsApiService: mockNewsApiService),
              ),
              Provider<ArticlesRepository>(
                create: (context) => mockArticlesRepository,
              ),
            ],
            child: const SourcesScreen(),
          ),
          routes: {
            '/saved': (context) =>
                const Scaffold(body: Text('Saved Articles Screen')),
          },
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.text('CNN'), findsOneWidget);
      expect(find.text('BBC News'), findsOneWidget);
      expect(find.byType(SourceCard), findsNWidgets(2));
    });

    testWidgets('SourcesScreen shows error message when source loading fails',
        (WidgetTester tester) async {
      final mockNewsApiService = MockNewsApiService(shouldReturnError: true);
      final mockArticlesRepository = MockArticlesRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) =>
                    SourcesViewModel(newsApiService: mockNewsApiService),
              ),
              Provider<ArticlesRepository>(
                create: (context) => mockArticlesRepository,
              ),
            ],
            child: const SourcesScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.text('Error: Exception: Failed to load sources'),
          findsOneWidget);
    });

    testWidgets(
        'SourcesScreen navigates to ArticlesScreen when a source card is tapped',
        (WidgetTester tester) async {
      final mockNewsApiService = MockNewsApiService();
      final mockArticlesRepository = MockArticlesRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) =>
                    SourcesViewModel(newsApiService: mockNewsApiService),
              ),
              Provider<ArticlesRepository>(
                create: (context) => mockArticlesRepository,
              ),
            ],
            child: const SourcesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('source_card_0')));
      await tester.pumpAndSettle();

      expect(find.byType(ArticlesScreen), findsOneWidget);
    });

    testWidgets(
        'SourcesScreen navigates to SavedArticlesScreen when bookmark button is tapped',
        (WidgetTester tester) async {
      final mockNewsApiService = MockNewsApiService();
      final mockArticlesRepository = MockArticlesRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) =>
                    SourcesViewModel(newsApiService: mockNewsApiService),
              ),
              Provider<ArticlesRepository>(
                create: (context) => mockArticlesRepository,
              ),
            ],
            child: const SourcesScreen(),
          ),
          routes: {
            '/saved': (context) =>
                const Scaffold(body: Text('Saved Articles Screen')),
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('bookmark_button')));
      await tester.pumpAndSettle();

      expect(find.text('Saved Articles Screen'), findsOneWidget);
    });
  });
}

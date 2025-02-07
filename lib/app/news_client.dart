import 'package:flutter/material.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';
import 'package:news_client/features/articles/repositories/implementations/cached_article_repository.dart';
import 'package:news_client/features/articles/services/implementations/news_api_service.dart';
import 'package:news_client/features/articles/view_models/saved_articles_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../features/articles/repositories/implementations/sqflite_articles_repository.dart';
import '../features/articles/view_models/sources_view_model.dart';
import '../features/articles/views/saved_articles_screen.dart';
import '../features/articles/views/sources_screen.dart';

class NewsClient extends StatelessWidget {
  const NewsClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ArticlesRepository>(
          create: (_) => CachedArticlesRepository(SqfliteArticlesRepository()),
        ),
        ChangeNotifierProvider<SourcesViewModel>(
          create: (_) =>
              SourcesViewModel(newsApiService: NewsApiService())..loadSources(),
        ),
        ChangeNotifierProvider<SavedArticlesScreenViewModel>(
          create: (context) => SavedArticlesScreenViewModel(
            articlesRepository: context.read<ArticlesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SourcesScreen(),
          '/saved': (context) => SavedArticlesScreen(),
        },
      ),
    );
  }
}

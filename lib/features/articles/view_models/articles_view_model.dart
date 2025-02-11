import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';
import 'package:news_client/features/articles/services/articles_refresh_service.dart';
import 'package:news_client/features/articles/services/news_service.dart';

import '../models/article.dart';
import '../models/source.dart';

class ArticlesViewModel extends ChangeNotifier {
  final NewsService _newsApiService;
  final ArticlesRepository _repository;
  final Source source;
  late final ArticlesRefreshService _articlesRefreshService;
  HashSet<String> _savedArticles = HashSet();

  ArticlesViewModel({
    newsApiService,
    required this.source,
    required ArticlesRepository repository,
    ArticlesRefreshService? articlesRefreshService, // Add optional parameter
  })  : _newsApiService = newsApiService,
        _repository = repository,
        _articlesRefreshService = articlesRefreshService ??
            ArticlesRefreshService([],
                newsService: newsApiService, sourceId: source.id) {
    loadArticles();
  }

  final List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;

  List<Article> get articles => _articles;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articlesRefreshService.addListener(() async {
        _articles.insertAll(0, _articlesRefreshService.value);
        await refreshSavedArticles();
      });
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  bool isSaved(Article article) {
    return _savedArticles.contains(article.url);
  }

  Future<void> toggleSaveArticle(Article article) async {
    if (!isSaved(article)) {
      await _repository.saveArticle(article);
    } else {
      await _repository.deleteArticle(article.url);
    }
    await refreshSavedArticles();
  }

  Future<void> refreshSavedArticles() async {
    try {
      _savedArticles =
          HashSet.from(await _repository.getSavedArticles().then((article) {
        return article.map((e) => e.url).toList();
      }));
    } catch (e) {
      debugPrint('Error refreshing saved articles: $e');
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';

import '../models/article.dart';

class SavedArticlesScreenViewModel extends ChangeNotifier {
  final ArticlesRepository _articlesRepository;
  List<Article> _savedArticles = [];
  List<Article> get savedArticles => _savedArticles;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SavedArticlesScreenViewModel({required ArticlesRepository articlesRepository})
      : _articlesRepository = articlesRepository;

  Future<void> loadSavedArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _savedArticles = await _articlesRepository.getSavedArticles();
    } catch (e) {
      _errorMessage = 'Failed to load saved articles: $e';
      _savedArticles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteArticle(String articleUrl) async {
    _errorMessage = null;
    try {
      await _articlesRepository.deleteArticle(articleUrl);
      _savedArticles.removeWhere((article) => article.url == articleUrl);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete article: $e';
      notifyListeners();
    }
  }
}

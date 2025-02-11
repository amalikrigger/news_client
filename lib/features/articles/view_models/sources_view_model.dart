import 'package:flutter/material.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/news_service.dart';

class SourcesViewModel extends ChangeNotifier {
  final NewsService _newsApiService;

  SourcesViewModel({newsApiService}) : _newsApiService = newsApiService;
  List<Source> _sources = [];
  bool _isLoading = false;
  String? _error;

  List<Source> get sources => _sources;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSources() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sources = await _newsApiService.fetchSources();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}

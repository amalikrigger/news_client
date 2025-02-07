import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/services/news_service.dart';

import '../../../shared/proxy_start_stoppable_timer.dart';
import '../../../shared/start_stoppable_timer.dart';

class ArticlesRefreshService extends ValueNotifier<List<Article>> {
  final NewsService _newsService;
  final String sourceId;
  final StartStoppableTimer _timer;
  DateTime? _lastRefreshTime;

  ArticlesRefreshService(
    super._value, {
    required NewsService newsService,
    required this.sourceId,
    StartStoppableTimer? timer,
  })  : _newsService = newsService,
        _timer = timer ??= ProxyStartStoppableTimer() {
    refreshArticles().then((_) {
      _timer.startTimer(
          duration: Duration(seconds: 1500),
          onTimer: () async {
            await refreshArticles();
          });
    });
  }

  Future<void> refreshArticles() async {
    value = await _newsService.fetchArticles(
      sourceId: sourceId,
      pageSize: 10,
      page: 1,
      sortBy: 'publishedAt',
      from: _lastRefreshTime,
    );
    if (value.isNotEmpty) {
      _lastRefreshTime = value.first.publishedAt?.add(Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.stopTimer();
  }
}

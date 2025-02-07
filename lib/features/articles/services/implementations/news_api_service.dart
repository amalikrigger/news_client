import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../models/article.dart';
import '../../models/source.dart';
import '../news_service.dart';

class NewsApiService implements NewsService {
  final http.Client _client;

  NewsApiService({http.Client? client}) : _client = client ?? http.Client();

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
    final Map<String, String> queryParams = {
      'sources': sourceId,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
      'sortBy': sortBy,
      'apiKey': apiKey,
    };

    if (query != null) {
      queryParams['q'] = query;
    }

    if (from != null) {
      queryParams['from'] = from.toIso8601String();
    }

    if (to != null) {
      queryParams['to'] = to.toIso8601String();
    }

    final uri =
        Uri.parse('$baseUrl/everything').replace(queryParameters: queryParams);
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return compute(_parseArticles, response.body);
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  @override
  Future<List<Source>> fetchSources() async {
    final uri = Uri.parse('$baseUrl/top-headlines/sources?apiKey=$apiKey');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return await compute(_parseSources, response.body);
    } else {
      throw Exception('Failed to fetch sources');
    }
  }

  void dispose() {
    _client.close();
  }
}

List<Article> _parseArticles(String responseBody) {
  final parsed = json.decode(responseBody)['articles'] as List;
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}

List<Source> _parseSources(String responseBody) {
  final parsed = json.decode(responseBody)['sources'] as List;
  return parsed.map<Source>((json) => Source.fromJson(json)).toList();
}

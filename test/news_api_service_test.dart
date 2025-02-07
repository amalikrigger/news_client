import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/services/implementations/news_api_service.dart';

import 'shared.dart';

void main() {
  group('NewsApiService', () {
    test('fetchArticles returns a list of articles on successful response',
        () async {
      final mockClient = MockClient((request) async {
        return http.Response.bytes(utf8.encode(json.encode(jsonResponse1)), 200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            });
      });

      final service = NewsApiService(client: mockClient);
      final articles = await service.fetchArticles(
          sourceId: 'sourceId', pageSize: 10, page: 1, sortBy: 'publishedAt');

      expect(articles, isA<List<Article>>());
      expect(articles.length, jsonResponse1['articles'].length);

      for (var i = 0; i < jsonResponse1['articles'].length; i++) {
        final expectedArticle = jsonResponse1['articles'][i];
        final actualArticle = articles[i];

        expect(actualArticle.title, expectedArticle['title']);
        expect(actualArticle.description, expectedArticle['description']);
        expect(actualArticle.url, expectedArticle['url']);
        expect(actualArticle.source.name, expectedArticle['source']['name']);
        expect(actualArticle.source.id, expectedArticle['source']['id']);
        expect(actualArticle.author, expectedArticle['author']);
        expect(actualArticle.urlToImage, expectedArticle['urlToImage']);
        expect(actualArticle.publishedAt,
            DateTime.parse(expectedArticle['publishedAt']));
        expect(actualArticle.content, expectedArticle['content']);
      }
    });

    test('fetchSources returns a list of sources on successful response',
        () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode(jsonResponse2), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });

      final service = NewsApiService(client: mockClient);
      final sources = await service.fetchSources();

      expect(sources, isA<List<Source>>());
      expect(sources.length, jsonResponse2['sources'].length);

      for (var i = 0; i < jsonResponse2['sources'].length; i++) {
        final expectedSource = jsonResponse2['sources'][i];
        final actualSource = sources[i];

        expect(actualSource.name, expectedSource['name']);
        expect(actualSource.id, expectedSource['id']);
        expect(actualSource.description, expectedSource['description']);
        expect(actualSource.url, expectedSource['url']);
        expect(actualSource.category, expectedSource['category']);
        expect(actualSource.language, expectedSource['language']);
        expect(actualSource.country, expectedSource['country']);
      }
    });
  });
}

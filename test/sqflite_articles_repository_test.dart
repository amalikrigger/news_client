import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_client/features/articles/models/article.dart';
import 'package:news_client/features/articles/repositories/implementations/sqflite_articles_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'shared.dart';

void main() {
  group('SqfliteArticlesRepository', () {
    late SqfliteArticlesRepository repository;
    late String testDatabasePath;
    late Database database;

    setUp(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      testDatabasePath =
          join(await getTemporaryDirectoryPath(), 'test_articles_database.db');
      Future<void> onCreateDb(Database db, int version) async {
        await db.execute('''
      CREATE TABLE articles (
        url TEXT UNIQUE PRIMARY KEY,
        title TEXT,
        description TEXT,
        source_id TEXT,
        source_name TEXT NOT NULL,
        author TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      )
    ''');
      }

      database = await openDatabase(testDatabasePath,
          version: 1, onCreate: onCreateDb);
      repository = SqfliteArticlesRepository(
        database: database,
      );
    });

    tearDown(() async {
      await repository.dispose();
      if (await File(testDatabasePath).exists()) {
        await File(testDatabasePath).delete();
      }
    });

    group('getSavedArticles', () {
      test('getSavedArticles_emptyDatabase_returnsEmptyList', () async {
        final articles = await repository.getSavedArticles();
        expect(articles, isEmpty);
      });

      test('getSavedArticles_withArticles_returnsListOfArticles', () async {
        final db = await repository.database;
        final sampleArticles = [
          Article(
            title: 'Article 1',
            url: 'url1',
            source: ArticleSource(name: 'Source 1', id: 'default_source_id_1'),
            description: 'Description 1',
            author: 'Default Author 1',
            urlToImage: 'http://example.com/image1.jpg',
            publishedAt: DateTime.now().subtract(Duration(days: 2)),
            content: 'Default content for Article 1',
          ),
          Article(
            title: 'Article 2',
            url: 'url2',
            source: ArticleSource(name: 'Source 2', id: 'default_source_id_2'),
            description: 'Description 2',
            author: 'Default Author 2',
            urlToImage: 'http://example.com/image2.jpg',
            publishedAt: DateTime.now().subtract(Duration(days: 1)),
            content: 'Default content for Article 2',
          ),
        ];

        for (final article in sampleArticles) {
          await db.insert('articles', {
            'title': article.title,
            'description': article.description,
            'url': article.url,
            'source_id': article.source.id,
            'source_name': article.source.name,
            'author': article.author,
            'urlToImage': article.urlToImage,
            'publishedAt': article.publishedAt?.toIso8601String(),
            'content': article.content,
          });
        }

        final articles = await repository.getSavedArticles();
        expect(articles.length, 2);
        compareArticleLists(articles, sampleArticles);
      });
    });

    group('saveArticle', () {
      test('saveArticle_singleArticle_articleIsSaved', () async {
        final sampleArticle = Article(
          title: 'Test Article',
          url: 'test_url',
          source: ArticleSource(name: 'Test Source'),
          description: 'Test Description',
        );

        await repository.saveArticle(sampleArticle);
        final articles = await repository.getSavedArticles();

        expect(articles.length, 1);
        compareArticleLists(articles, [sampleArticle]);
      });

      test('saveArticle_multipleArticles_allArticlesAreSaved', () async {
        final sampleArticles = [
          Article(
            title: 'Article A',
            url: 'url_a',
            source: ArticleSource(name: 'Source A', id: 'default_source_id_A'),
            description: 'Description A',
            author: 'Default Author A',
            urlToImage: 'http://example.com/image_a.jpg',
            publishedAt: DateTime.now().subtract(Duration(days: 1)),
            content: 'Default content for Article A',
          ),
          Article(
            title: 'Article B',
            url: 'url_b',
            source: ArticleSource(name: 'Source B', id: 'default_source_id_B'),
            description: 'Description B',
            author: 'Default Author B',
            urlToImage: 'http://example.com/image_b.jpg',
            publishedAt: DateTime.now(),
            content: 'Default content for Article B',
          ),
        ];

        for (final article in sampleArticles) {
          await repository.saveArticle(article);
        }

        final articles = await repository.getSavedArticles();
        expect(articles.length, 2);
        compareArticleLists(articles, sampleArticles);
      });

      test('saveArticle_conflictReplace_replacesExistingArticle', () async {
        final initialArticle = Article(
          title: 'Initial Article',
          url: 'same_url',
          source:
              ArticleSource(name: 'Source Initial', id: 'initial_source_id'),
          description: 'Initial Description',
          author: 'Initial Author',
          urlToImage: 'http://example.com/initial_image.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 3)),
          content: 'Initial Content',
        );
        await repository.saveArticle(initialArticle);

        final updatedArticle = Article(
          title: 'Updated Article',
          url: 'same_url',
          source:
              ArticleSource(name: 'Source Updated', id: 'updated_source_id'),
          description: 'Updated Description',
          author: 'Updated Author',
          urlToImage: 'http://example.com/updated_image.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 1)),
          content: 'Updated Content',
        );

        await repository.saveArticle(updatedArticle);

        final articles = await repository.getSavedArticles();
        expect(articles.length, 1);
        compareArticleLists(articles, [updatedArticle]);
      });
    });

    group('deleteArticle', () {
      test('deleteArticle_existingArticle_articleIsDeleted', () async {
        final sampleArticle = Article(
          title: 'Article to Delete',
          url: 'delete_url',
          source: ArticleSource(name: 'Delete Source', id: 'delete_source_id'),
          description: 'Delete Description',
          author: 'Delete Author',
          urlToImage: 'http://example.com/delete_image.jpg',
          publishedAt: DateTime.now().subtract(Duration(days: 7)),
          content: 'Delete Content',
        );

        await repository.saveArticle(sampleArticle);

        await repository.deleteArticle('delete_url');
        final articles = await repository.getSavedArticles();
        expect(articles, isEmpty);
      });

      test('deleteArticle_nonExistingArticle_databaseUnchanged', () async {
        final sampleArticle = Article(
          title: 'Article to Keep',
          url: 'keep_url',
          source: ArticleSource(name: 'Keep Source'),
          description: 'Keep Description',
        );
        await repository.saveArticle(sampleArticle);

        await repository.deleteArticle('non_existent_url');
        final articles = await repository.getSavedArticles();
        expect(articles.length, 1);
        compareArticleLists(articles, [sampleArticle]);
      });
    });
  });
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/article.dart';
import '../articles_repository.dart';

class SqfliteArticlesRepository implements ArticlesRepository {
  Database? _database;

  SqfliteArticlesRepository({Database? database}) {
    _database = database;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'articles_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreateDb);
  }

  Future<void> _onCreateDb(Database db, int version) async {
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

  @override
  Future<void> deleteArticle(String id) async {
    final db = await database;
    await db.delete(
      'articles',
      where: 'url = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');

    return List.generate(maps.length, (i) {
      return Article(
        title: maps[i]['title'] ?? '',
        description: maps[i]['description'] ?? '',
        url: maps[i]['url'] ?? '',
        source: ArticleSource(
          id: maps[i]['source_id'],
          name: maps[i]['source_name'] ?? '',
        ),
        author: maps[i]['author'],
        urlToImage: maps[i]['urlToImage'],
        publishedAt: maps[i]['publishedAt'] != null
            ? DateTime.parse(maps[i]['publishedAt'])
            : null,
        content: maps[i]['content'],
      );
    });
  }

  @override
  Future<void> saveArticle(Article article) async {
    final db = await database;
    await db.insert(
        'articles',
        {
          'title': article.title,
          'description': article.description,
          'url': article.url,
          'source_id': article.source.id,
          'source_name': article.source.name,
          'author': article.author,
          'urlToImage': article.urlToImage,
          'publishedAt': article.publishedAt?.toIso8601String(),
          'content': article.content,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> dispose() {
    return _database?.close() ?? Future.value();
  }
}

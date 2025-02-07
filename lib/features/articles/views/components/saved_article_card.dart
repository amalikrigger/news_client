import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../view_models/saved_articles_screen_view_model.dart';
import '../article_detail_screen.dart';
import 'article_card.dart';

class SavedArticleCard extends StatelessWidget {
  final Article article;
  final SavedArticlesScreenViewModel viewModel;

  const SavedArticleCard({
    super.key,
    required this.article,
    required this.viewModel,
  });

  void _onBookmarkPressed(BuildContext context) async {
    await viewModel.deleteArticle(article.url);
  }

  void _navigateToArticleDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailsScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ArticleCard(
      article: article,
      isSaved: true,
      onTap: () => _navigateToArticleDetail(context),
      onBookmarkPressed: () => _onBookmarkPressed(context),
    );
  }
}

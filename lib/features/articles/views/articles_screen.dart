import 'package:flutter/material.dart';

import '../models/article.dart';
import '../models/source.dart';
import '../view_models/articles_view_model.dart';
import 'article_detail_screen.dart';
import 'components/article_card.dart';

class ArticlesScreen extends StatefulWidget {
  final ArticlesViewModel viewModel;

  const ArticlesScreen({super.key, required this.viewModel});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  void _onBookmarkPressed(Article article) async {
    await widget.viewModel.toggleSaveArticle(article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, widget.viewModel.source),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Source source) {
    return AppBar(
      title: Text(
        'Latest Articles',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      surfaceTintColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            overflow: TextOverflow.ellipsis,
            widget.viewModel.source.description,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 3,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark),
          tooltip: 'View Saved Articles',
          onPressed: () async {
            await Navigator.pushNamed(context, '/saved');
            widget.viewModel.refreshSavedArticles();
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (BuildContext context, Widget? child) {
        if (widget.viewModel.isLoading) {
          return _buildLoadingIndicator();
        } else if (widget.viewModel.error != null) {
          return _buildErrorView(widget.viewModel.error!);
        } else if (widget.viewModel.articles.isEmpty) {
          return _buildEmptyView();
        } else {
          return _buildArticleList();
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              'An error occurred while loading news.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: widget.viewModel.loadArticles,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.newspaper, color: Colors.grey, size: 60),
            const SizedBox(height: 16),
            Text(
              'No news available at the moment.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later or try refreshing.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: widget.viewModel.loadArticles,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleList() {
    return ListView.builder(
      itemCount: widget.viewModel.articles.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Article article = widget.viewModel.articles[index];
        return ArticleCard(
          article: article,
          isSaved: widget.viewModel.isSaved(article),
          onTap: () => _navigateToArticleDetail(article),
          onBookmarkPressed: () => _onBookmarkPressed(article),
        );
      },
    );
  }

  void _navigateToArticleDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailsScreen(article: article),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_client/features/articles/models/source.dart';
import 'package:news_client/features/articles/repositories/articles_repository.dart';
import 'package:news_client/features/articles/services/implementations/news_api_service.dart';
import 'package:news_client/features/articles/view_models/sources_view_model.dart';
import 'package:provider/provider.dart';

import '../view_models/articles_view_model.dart';
import 'articles_screen.dart';
import 'components/source_card.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SourcesViewModel>(context, listen: false).loadSources();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SourcesViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('News Sources'),
      surfaceTintColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: () async {
            await Navigator.pushNamed(context, '/saved');
          },
        ),
      ],
    );
  }

  Widget _buildBody(SourcesViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.error != null) {
      return Center(child: Text('Error: ${viewModel.error}'));
    } else {
      return _buildSourcesList(viewModel.sources);
    }
  }

  Widget _buildSourcesList(List<Source> sources) {
    return ListView.builder(
      itemCount: sources.length,
      itemBuilder: (context, index) {
        final Source source = sources[index];
        return SourceCard(
          source: source,
          onTap: () {
            _navigateToArticlesScreen(context, source);
          },
        );
      },
    );
  }

  void _navigateToArticlesScreen(BuildContext context, Source source) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticlesScreen(
          viewModel: ArticlesViewModel(
            newsApiService: NewsApiService(),
            source: source,
            repository: context.read<ArticlesRepository>(),
          ),
        ),
      ),
    );
  }
}

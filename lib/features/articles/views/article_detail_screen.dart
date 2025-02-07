import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailsScreen({super.key, required this.article});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(article.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch ${article.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildArticleTitle(context),
              const SizedBox(height: 16),
              _buildArticleSourceAndDate(context),
              const SizedBox(height: 24),
              _buildArticleDescription(context),
              const SizedBox(height: 32),
              _buildReadFullArticleButton(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        article.source.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 1,
      iconTheme: Theme.of(context).iconTheme,
    );
  }

  Widget _buildArticleTitle(BuildContext context) {
    return Text(
      article.title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ) ??
          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildArticleSourceAndDate(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.source, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          'Source: ${article.source.name}',
          style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey[600]) ??
              TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          _formatDate(article.publishedAt),
          style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey[600]) ??
              TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Date not available';
    }
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  Widget _buildArticleDescription(BuildContext context) {
    return Text(
      article.description,
      style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 16, height: 1.5) ??
          const TextStyle(fontSize: 16, height: 1.5),
    );
  }

  Widget _buildReadFullArticleButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _launchURL,
        icon: const Icon(Icons.open_in_browser),
        label: const Text('Read Full Article in Browser'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}

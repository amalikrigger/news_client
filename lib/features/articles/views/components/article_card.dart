import 'package:flutter/material.dart';

import '../../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onBookmarkPressed;

  const ArticleCard({
    super.key,
    required this.article,
    required this.isSaved,
    required this.onTap,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Source: ${article.source.name}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ) ??
                        TextStyle(color: Colors.grey[600]),
                  ),
                  IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.blue : Colors.grey,
                    ),
                    onPressed: onBookmarkPressed,
                    tooltip: isSaved ? 'Remove from Saved' : 'Save Article',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

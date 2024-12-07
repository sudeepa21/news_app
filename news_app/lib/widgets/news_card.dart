import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../screens/details_screen.dart'; // Import the details screen

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onRemove; // Optional callback for removing saved articles

  const NewsCard({required this.article, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isSaved =
        Provider.of<NewsService>(context).getSavedArticles().contains(article);

    return Card(
      child: ListTile(
        leading:
            article.imageUrl.isNotEmpty && article.imageUrl.startsWith('http')
                ? Image.network(
                    article.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  )
                : const Icon(Icons.broken_image, size: 100),
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Text(_formatDate(article.publishedAt)), // Format the date here
        trailing: IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color:
                isSaved ? const Color.fromARGB(255, 62, 128, 202) : Colors.grey,
          ),
          onPressed: () {
            if (isSaved) {
              Provider.of<NewsService>(context, listen: false)
                  .removeSavedArticle(article);
              if (onRemove != null) onRemove!(); // Trigger onRemove if provided
            } else {
              Provider.of<NewsService>(context, listen: false)
                  .saveArticle(article);
            }
          },
        ),
        onTap: () {
          // Navigate to DetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(article: article),
            ),
          );
        },
      ),
    );
  }

  // Helper method to format the date
  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}

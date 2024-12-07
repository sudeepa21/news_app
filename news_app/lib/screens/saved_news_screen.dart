import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../screens/details_screen.dart';
import 'package:provider/provider.dart';

class SavedNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedArticles = Provider.of<NewsService>(context).getSavedArticles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: savedArticles.isEmpty
          ? const Center(
              child: Text(
                'No saved news articles.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                final article = savedArticles[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    leading: article.imageUrl.isNotEmpty &&
                            article.imageUrl.startsWith('http')
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
                    subtitle: Text(article.publishedAt),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark,
                          color: Color.fromARGB(255, 49, 145, 209)),
                      onPressed: () {
                        Provider.of<NewsService>(context, listen: false)
                            .removeSavedArticle(article);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Removed from saved articles')),
                        );
                      },
                    ),
                    onTap: () {
                      // Navigate to the details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

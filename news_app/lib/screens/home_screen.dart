import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'saved_news_screen.dart';
import 'category_grid_screen.dart';
import 'settings_screen.dart';
import 'search_screen.dart';
import '../services/news_service.dart';
import '../models/article.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _sortOption = "Latest"; // Default sorting option

  Future<List<Article>> _fetchSortedArticles(BuildContext context) async {
    final newsService = Provider.of<NewsService>(context, listen: false);
    List<Article> articles;

    // Fetch and sort articles based on the selected option
    if (_sortOption == "Title") {
      articles = await newsService.fetchTopHeadlines();
      articles = newsService.sortArticles("Title"); // Sort by Title
    } else {
      articles = await newsService.fetchTopHeadlines(); // Default to Latest
    }

    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Global ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'News',
                style: TextStyle(
                  color: const Color.fromARGB(255, 40, 86, 146),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Search Button
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          // Sorting Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortOption = value; // Update sorting option
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Latest",
                child: Text("Latest News"),
              ),
              PopupMenuItem(
                value: "Title",
                child: Text("Sort by Title"),
              ),
            ],
            icon: Icon(Icons.sort, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder<List<Article>>(
        future: _fetchSortedArticles(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final articles = snapshot.data!;
            if (articles.isEmpty) {
              return Center(child: Text('No articles found.'));
            }
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  NewsCard(article: articles[index]),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 46, 115, 172),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryGridScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedNewsScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
      ),
    );
  }
}

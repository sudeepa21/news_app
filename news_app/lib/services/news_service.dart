import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService with ChangeNotifier {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = '88afbc22b1d34e0687d399def16d1863'; //  API key

  List<Article> _savedArticles = []; // List to store saved articles
  List<Article> _articles =
      []; // Store fetched articles for sorting and manipulation

  // Fetch top headlines
  Future<List<Article>> fetchTopHeadlines() async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey');
    _articles = await _fetchArticles(url, 'Top Headlines');
    return _articles;
  }

  // Fetch articles by category
  Future<List<Article>> fetchByCategory(String category) async {
    final url = Uri.parse(
        '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
    _articles = await _fetchArticles(url, 'Category: $category');
    return _articles;
  }

  // Search articles by query
  Future<List<Article>> searchArticles(String query) async {
    final url = Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey');
    return await _fetchArticles(url, 'Search Query: $query');
  }

  // Fetch trending news
  Future<List<Article>> fetchTrendingNews() async {
    final url = Uri.parse(
        '$_baseUrl/top-headlines?country=us&sortBy=popularity&apiKey=$_apiKey');
    _articles = await _fetchArticles(url, 'Trending News');
    return _articles;
  }

  // Sort articles dynamically based on selected criteria
  List<Article> sortArticles(String criteria) {
    if (criteria == "Latest") {
      _articles.sort((a, b) =>
          b.publishedAt.compareTo(a.publishedAt)); // Descending by date
    } else if (criteria == "Title") {
      _articles.sort((a, b) => a.title
          .toLowerCase()
          .compareTo(b.title.toLowerCase())); // Ascending by title
    }
    notifyListeners(); // Notify listeners about the changes
    return _articles;
  }

  // Helper function to fetch articles and handle API responses
  Future<List<Article>> _fetchArticles(Uri url, String context) async {
    try {
      print('Fetching $context from URL: $url');
      final response = await http.get(url);

      print('Response Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Number of articles fetched: ${data['articles']?.length ?? 0}');
        return (data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .where((article) =>
                article.imageUrl.isNotEmpty &&
                article.imageUrl.startsWith('http') &&
                !article.title.contains("[Removed]")) // Filter invalid articles
            .toList();
      } else {
        print('Failed to fetch $context. Response: ${response.body}');
        throw Exception('Failed to fetch $context');
      }
    } catch (e) {
      print('Error fetching $context: $e');
      throw Exception('Error fetching $context');
    }
  }

  // Add an article to saved articles
  void saveArticle(Article article) {
    if (!_savedArticles.contains(article)) {
      _savedArticles.add(article);
      notifyListeners(); // Notify listeners about the change
      print('Article saved: ${article.title}');
    }
  }

  // Remove an article from saved articles
  void removeSavedArticle(Article article) {
    _savedArticles.remove(article);
    notifyListeners(); // Notify listeners about the change
    print('Article removed: ${article.title}');
  }

  // Get all saved articles
  List<Article> getSavedArticles() {
    print('Number of saved articles: ${_savedArticles.length}');
    return _savedArticles;
  }
}

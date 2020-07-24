import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/article.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/services/articles_service.dart';

class ArticlesProvider with ChangeNotifier {
  ArticlesProvider() {
    fetchArticles();
  }

  ArticlesService _articleService = ArticlesService();
  List<Article> _articles;

  List<Article> get articles => _articles;

  Future<List<Article>> fetchArticles() async {
    try {
      _articles = await _articleService.fetchArticles(/* user */);
      notifyListeners();
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> fetchFamiliesArticles() async {
    try {
      _articles = await _articleService.fetchArticles(/* user */);
      notifyListeners();
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postArticle(User user, Article article) async {
    try {
      await _articleService.postArticle(user, article);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

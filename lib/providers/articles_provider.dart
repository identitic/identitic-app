import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/article.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/services/articles_service.dart';

class ArticlesProvider with ChangeNotifier {
  
  ArticlesService _articleService = ArticlesService();
  List<Article> _articles;

  List<Article> get articles => _articles;

  Future<List<Article>> fetchArticles(int idClass) async {
    try {
      _articles = await _articleService.fetchArticles(idClass);
      notifyListeners();
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> fetchFamiliesArticles(int idSchool) async {
    try {
      _articles = await _articleService.fetchArticles(idSchool);
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

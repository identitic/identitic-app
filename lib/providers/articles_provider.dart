import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/articles/delivery.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/services/articles_service.dart';

class ArticlesProvider with ChangeNotifier {
  ArticlesService _articlesService = ArticlesService();

  List<Article> _articles;
  List<Delivery> _deliveries;

  List<Article> get articles => _articles;
  List<Delivery> get deliveries => _deliveries;

  Future<List<Article>> fetchArticles(int idClass, int idUser) async {
    try {
      _articles = await _articlesService.fetchArticles(idClass, idUser);
      notifyListeners();
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> fetchFamiliesArticles(int idSchool, int idUser) async {
    try {
      _articles = await _articlesService.fetchArticles(idSchool, idUser);
      notifyListeners();
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postArticle(User user, Article article) async {
    try {
      await _articlesService.postArticle(user, article);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadDelivery(Delivery delivery) async {
    try {
      await _articlesService.uploadDelivery(delivery);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadReturn(dynamic _return) async {
    try {
      await _articlesService.uploadReturn(_return);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchDeliveriesByPost(Article article) async {
    try {
      _deliveries = await _articlesService.fetchDeliveriesByPost(article);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return _deliveries;
  }
}

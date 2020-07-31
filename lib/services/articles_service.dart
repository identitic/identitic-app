import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:identitic/models/article.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/utils/constants.dart';

class ArticlesService {
  Future<List<Article>> fetchArticles(/* User user */) async {
    List<Article> articles;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/admin/getpostbysc/1',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            articles = list.map((e) => Article.fromJson(e)).toList();
            break;
          }
        case 401:
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e);
    }
    return articles;
  }

  Future<List<Article>> fetchFamiliesArticles(/* User user */) async {
    List<Article> articles;

    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/admin/getpostbycategory/1',
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            articles = list.map((e) => Article.fromJson(e)).toList();
            break;
          }
        case 401:
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e);
    }
    return articles;
  }

  Future<void> postArticle(User user, Article article) async {
    const Map<String, String> jsonHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response =
          await http.post('$apiBaseUrl/admin/createpost',
              headers: jsonHeaders,
              body: jsonEncode({
                'id_sc': user.idSchool,
                'id_user': user.id,
                'title': article.title,
                'body': article.body,
                'date': article.date,
                'id_hierarchy': article.hierarchy,
                'deadline': article.deadline
              }));
      switch (response.statusCode) {
        case 200:
          debugPrint(response.body);
          break;
        case 401:
          debugPrint(response.body);
          throw UnauthorizedException('UnauthorizedException: Voló todo');
        case 429:
          debugPrint(response.body);
          throw TooManyRequestsException('TooManyRequestsException: Voló todo');
      }
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

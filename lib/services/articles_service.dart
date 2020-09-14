import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';

import 'package:identitic/models/article.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class ArticlesService {
  Future<List<Article>> fetchArticles(int idClass) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Article> articles;

    final Map<String, String> jsonHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/admin/getpostbyidclass/$idClass',
        headers: jsonHeaders,
      );
      debugPrint(response.body);
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

  Future<List<Article>> fetchFamiliesArticles(int idSchool) async {
    List<Article> articles;
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    final Map<String, String> jsonHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    try {
      final http.Response response = await http.get(
        '$apiBaseUrl/admin/getpostbyhierarchyid/1',
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
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    Dio dio = new Dio();
    try {
      Map<String, dynamic> data = {
        "filee": article.image != null ? await MultipartFile.fromFile(article.image.path,
            filename: article.image.path.split('/').last,
            contentType: MediaType('image', 'jpg')) : null,
        "title": article.title,
        "body": article.body,
        "markdown": article.markdown,
        "id_sc": article.idJoin,
        "id_hierarchy": article.hierarchy,
        "date": DateTime.now().toString(),
        "deadline": article.deadline
      };

      FormData formData = FormData.fromMap(data);

      print(formData.fields);
      var response = await dio.post(
        '$apiBaseUrl/general/uploadPost',
        data: formData,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );
      print(response.data);
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

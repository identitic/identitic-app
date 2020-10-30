import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/articles/delivery.dart';
import 'package:identitic/models/user.dart';
import 'package:identitic/services/exceptions.dart';
import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class ArticlesService {
  Future<List<Article>> fetchArticles(int idClass, int idUser) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    List<Article> articles;

    var params = {'id_class': idClass, "id_user": idUser};

    try {
      final http.Response response = await http.post(
        '$apiBaseUrl/admin/getpostbyidclass',
        body: json.encode(params),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
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
        '$apiBaseUrl/admin/getpostbyhierarchyid/1', //TODO: Arreglar families posts
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
        "filee": article.image != null
            ? await MultipartFile.fromFile(article.image.path,
                filename: article.image.path.split('/').last,
                contentType: MediaType('image', 'jpg'))
            : null,
        "title": article.title,
        "body": article.body,
        "markdown": article.markdown,
        "id_sc": article.idJoin,
        "id_hierarchy": article.idHierarchy,
        "date": DateTime.now().toIso8601String().toString(),
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

  Future<List<Delivery>> fetchDeliveriesByPost(Article article) async {
    List<Delivery> deliveries;

    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    var jsonHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var params = {"id_post": article.idArticle, "id_class": article.idClass};

    try {
      final http.Response response = await http.post(
          '$apiBaseUrl/teacher/getdeliveriesbyidpost',
          body: json.encode(params),
          headers: jsonHeaders);
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list =
                json.decode(response.body)['data']['students'];
            deliveries = list.map((e) => Delivery.fromJson(e)).toList();
            print(deliveries);
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

    return deliveries;
  }

  Future<void> uploadDelivery(Delivery delivery) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    try {
      var jsonHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      Map<String, dynamic> params = {
        "id_post": delivery.idArticle,
        "body": delivery.body,
        "filee": delivery.file,
        "date": delivery.date,
      };

      final http.Response response = await http.post(
          '$apiBaseUrl/general/uploaddelivery',
          headers: jsonHeaders,
          body: json.encode(params));
      debugPrint(json.encode(params));
      debugPrint(response.body);

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

  Future<void> uploadReturn(dynamic _return) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    try {
      var jsonHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      http.Response response = await http.post(
        '$apiBaseUrl/general/uploaddeliveryreturn',
        headers: jsonHeaders,
        body: json.encode(_return),
      );
      debugPrint(json.encode(_return));
      debugPrint(response.body);
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

  Future<List<Delivery>> fetchReturnOfDelivery(Article article) async {
    List<Delivery> deliveries;
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    var jsonHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var params = {'id_post': article.idArticle};

    try {
      final http.Response response = await http.post(
        '$apiBaseUrl/admin/getreturnbypost',
        body: json.encode(params),
        headers: jsonHeaders,
      );
      switch (response.statusCode) {
        case 200:
          {
            final Iterable<dynamic> list = json.decode(response.body)['data'];
            deliveries = list.map((e) => Delivery.fromJson(e)).toList();
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

    return deliveries;
  }
}

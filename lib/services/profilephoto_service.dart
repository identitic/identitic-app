import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:identitic/services/storage_service.dart';
import 'package:identitic/utils/constants.dart';

class ProfilePhotoService {
  Future<void> uploadPhoto(File photo) async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);

    Dio dio = new Dio();

    Map<String, dynamic> data = {
      "filee": photo != null
          ? await MultipartFile.fromFile(photo.path,
              filename: photo.path.split('/').last,
              contentType: MediaType('image', 'jpeg'))
          : null
    };
    var formData = FormData.fromMap(data);
    print(formData.fields);

    try {
      await dio
          .post(
            '$apiBaseUrl/general/uploadProfPic',
            data: formData,
            options: Options(
              headers: {
                "Authorization": 'Bearer $token',
              },
            ),
          )
          .then((response) => print(response));
    } on SocketException {
      throw const SocketException('SocketException: Voló todo');
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:opx_certification/core/config.dart';
import 'package:opx_certification/core/shared_pref.dart';

Dio dio = Dio();

class LoginRepo {
  static Future<Response?> loginUser(String email, String password) async {
    try {
      final response = await dio.post('${Config.stagingUrl}users/login',
          data: {
            "email": email,
            "password": password,
          },
          options: Options(contentType: "application/json"));
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        await SharedPref.setUsername(response.data['data']['name']);
        await SharedPref.setToken(response.data['data']['token']);
        await SharedPref.setEmail(response.data['data']['email']);
        return response;
      }
      if (response.statusCode == 422) {
        return response;
      }
    } catch (e) {
      log('Error:$e');
      return null;
    }
    return null;
  }
}

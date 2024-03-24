import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:opx_certification/core/config.dart';
import 'package:opx_certification/core/shared_pref.dart';

Dio dio = Dio();

class SignupRepo {
  static Future<Response?> registerUser(
      String name, String email, String password, String phone, String siren, String company) async {
    try {
      final response = await dio.post('${Config.stagingUrl}users/register',
          options: Options(contentType: "application/json"),
          data: {
            "name": name,
            "email": email,
            "password": password,
            "phone": phone,
            "siren": siren,
            "company": company
          });
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        // await SharedPref.setUsername(response.data['data']['token']);
        // await SharedPref.setToken(response.data['data']['token']);
        // await SharedPref.setEmail(response.data['data']['token']);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }
}

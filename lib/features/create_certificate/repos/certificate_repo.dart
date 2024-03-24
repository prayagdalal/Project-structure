import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opx_certification/core/config.dart';
import 'package:opx_certification/core/shared_pref.dart';
import 'package:opx_certification/features/create_certificate/models/certificate_model.dart';
import 'package:opx_certification/features/create_certificate/models/operations_model.dart';

Dio dio = Dio();

class CertificateRepo {
  static Future<OperationsModel?> getOperations() async {
    try {
      final response = await dio.get('${Config.stagingUrl}operations');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        OperationsModel operationModel = OperationsModel.fromJson(response.data);
        return operationModel;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<CertificateModel?> getCertificates() async {
    String? token = SharedPref.getToken();

    try {
      if (token != null) {
        log('token---$token');
        final response = await dio.get('${Config.stagingUrl}certifications',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }));
        if (response.statusCode! >= 200 && response.statusCode! <= 300) {
          CertificateModel certificateModel = CertificateModel.fromJson(response.data);
          return certificateModel;
        }
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<Response?> createCertificate(String operationId, String housingType, int numberOfRooms, String fullName,
      String address, List<dynamic> images, bool localisation) async {
    try {
      String? token = SharedPref.getToken();
      Map<String, dynamic> dataMap = {
        'operation_id': operationId,
        'housing_type': housingType,
        'no_rooms': numberOfRooms,
        'full_name': fullName,
        'address': address,
        'localisation': 1
      };
      var formData = FormData.fromMap(dataMap);

      for (int i = 0; i < images.length; i++) {
        dynamic imageData = images[i];
        if (imageData.containsKey('room_picture')) {
          XFile? roomPicture = imageData['room_picture'];
          if (roomPicture != null) {
            formData.files.add(MapEntry(
                'images[]',
                await MultipartFile.fromFile(
                  roomPicture.path,
                  filename: roomPicture.path.split('/').last,
                )));
          }
        }
      }
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await dio.post(
        '${Config.stagingUrl}certifications',
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return response;
      }
      if (response.statusCode == 422) {
        return response;
      }
    } catch (e) {
      log('Error creating certificate: $e');
      return null;
    }
    return null;
  }
}

// import 'dart:io';

import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:dio/dio.dart';

class KlasifikasiServices {
  String url = "http://192.168.179.80:8000/api/predict";
  Dio dio = Dio();

  Future klasifikasi(XFile gambar) async {
    String fileName = gambar.path.split('/').last;

    try {
      var formData = FormData.fromMap({
        'gambar': await MultipartFile.fromFile(gambar.path, filename: fileName)
      });
      var response = await dio.post(url,
          data: formData,
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.statusCode == 200) {
        print("ini adalah data ${response.data}");
        final data = jsonDecode(response.data);

        KlasifikasiModel klasifikasiModel = KlasifikasiModel.fromJson(data);
        // print("Klasifikasi Model $klasifikasiModel");
        return klasifikasiModel;
      } else {
        throw Exception("Gagal Klasifikasi");
      }
    } on DioError catch (e) {
      throw Exception("Salah $e");
    }
  }
}

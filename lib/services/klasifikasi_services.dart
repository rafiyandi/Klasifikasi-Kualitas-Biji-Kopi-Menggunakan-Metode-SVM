// import 'dart:io';

import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:dio/dio.dart';

class KlasifikasiServices {
  String url = "http://192.168.96.80:8000/api/predict";
  Dio dio = Dio();

  Future<KlasifikasiModel> klasifikasi(XFile gambar) async {
    String fileName = gambar.path.split('/').last;
    print("ini gambar" + gambar.toString());

    try {
      var formData = FormData.fromMap({
        'gambar': await MultipartFile.fromFile(gambar.path, filename: fileName)
      });
      var response = await dio.post(url,
          data: formData,
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.statusCode == 200) {
        print("ini adalah data ${response.data}");
        final data = response.data;

        KlasifikasiModel klasifikasiModel = KlasifikasiModel.fromJson(data);
        // print("Klasifikasi Model $klasifikasiModel");
        return klasifikasiModel;
      } else {
        throw Exception("Gagal Klasifikasi");
      }
    } on DioError catch (e) {
      switch (e.response!.statusCode) {
        case 400:
          final data = e.response?.data;

          return data;
        case 500:
          final data = e.response?.data;
          return data;
      }
      throw Exception(e);
    }
  }
}

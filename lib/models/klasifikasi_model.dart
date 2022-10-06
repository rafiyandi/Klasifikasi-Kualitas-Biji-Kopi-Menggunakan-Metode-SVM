import 'dart:io';

class KlasifikasiModel {
  String? hasil;
  String? urlAsli;
  String? urlGRY;
  String? urlLBP;

  KlasifikasiModel({this.hasil, this.urlAsli, this.urlGRY, this.urlLBP});

  KlasifikasiModel.fromJson(Map<String, dynamic> json) {
    hasil = json['hasil'];
    urlAsli = json['urlAsli'];
    urlGRY = json['urlGRY'];
    urlLBP = json['urlLBP'];
  }

  Map<String, dynamic> toJson() {
    return {
      'hasil': hasil,
      'urlAsli': urlAsli,
      'urlGRY': urlGRY,
      'urlLBP': urlLBP
    };
  }
}

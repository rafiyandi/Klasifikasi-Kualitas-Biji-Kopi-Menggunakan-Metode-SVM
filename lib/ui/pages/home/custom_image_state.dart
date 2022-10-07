import 'package:flutter/material.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomImageResult extends StatelessWidget {
  CustomImageResult({Key? key, required this.hasil}) : super(key: key);
  final String hasil;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: kGreyColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(hasil), fit: BoxFit.cover),
      ),
    );
  }
}

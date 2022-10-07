import 'package:flutter/material.dart';
import 'package:kopi/models/klasifikasi_model.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomImageResult extends StatelessWidget {
  const CustomImageResult({Key? key, required this.hasil, required this.text})
      : super(key: key);
  final String hasil;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text(
            text,
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: kGreyColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(hasil), fit: BoxFit.fitHeight),
            ),
          ),
        ],
      ),
    );
  }
}

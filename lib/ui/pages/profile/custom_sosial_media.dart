import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomSosialMedia extends StatelessWidget {
  const CustomSosialMedia({Key? key, required this.imgUrl, required this.text})
      : super(key: key);
  final String imgUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imgUrl,
          width: 20,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: kWhiteTextStyle,
        ),
      ],
    );
  }
}

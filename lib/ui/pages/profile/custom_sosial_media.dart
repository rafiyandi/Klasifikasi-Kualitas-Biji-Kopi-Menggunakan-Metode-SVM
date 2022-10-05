import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomSosialMedia extends StatelessWidget {
  CustomSosialMedia(
      {Key? key,
      required this.imgUrl,
      required this.text,
      required this.onPressed})
      : super(key: key);
  final String imgUrl;
  final String text;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
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
      ),
    );
  }
}

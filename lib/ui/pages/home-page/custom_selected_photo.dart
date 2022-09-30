import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomSelectedPhoto extends StatelessWidget {
  const CustomSelectedPhoto(
      {Key? key, required this.imgUrl, required this.text, required this.onTap})
      : super(key: key);
  final String imgUrl;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: kSecondBlackColor.withOpacity(0.1), width: 2),
            ),
            child: Image.asset(
              imgUrl,
              width: double.infinity,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          text,
          style: blackTextStyle,
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomSliderOnboarding extends StatelessWidget {
  CustomSliderOnboarding(
      {super.key,
      required this.imgUrl,
      required this.titleText,
      required this.text,
      required this.margin});
  final String imgUrl;
  final String titleText;
  final String text;
  EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          Image.asset(
            imgUrl,
            width: double.infinity,
          ),
          SizedBox(height: 20),
          Text(
            titleText,
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
          ),
          SizedBox(height: 30),
          Text(
            text,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomStepBantuan extends StatelessWidget {
  const CustomStepBantuan(
      {Key? key,
      required this.imgUrl,
      required this.step,
      required this.text,
      this.isLeft = false})
      : super(key: key);
  final String imgUrl;
  final String step;
  final String text;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return !isLeft
        ? Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Image.asset(
                  imgUrl,
                  width: 80,
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step,
                        style: blackTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        text,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        step,
                        style: blackTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        text,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                Image.asset(
                  imgUrl,
                  width: 80,
                ),
              ],
            ),
          );
  }
}

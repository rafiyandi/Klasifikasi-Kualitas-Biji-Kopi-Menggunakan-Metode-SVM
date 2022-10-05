import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomBiodata extends StatelessWidget {
  const CustomBiodata(
      {Key? key, required this.imgUrl, required this.title, required this.text})
      : super(key: key);
  final String imgUrl;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imgUrl,
                width: 18,
                color: kGreyColor,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: kGreyTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold, letterSpacing: 2),
                    ),
                    SizedBox(height: 10),
                    Text(
                      text,
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          letterSpacing: 1,
                          color: kBlackColor.withOpacity(0.7)),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: double.infinity,
            height: 0.5,
            color: kGreyColor.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}

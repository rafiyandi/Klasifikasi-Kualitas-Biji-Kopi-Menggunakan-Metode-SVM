import 'package:flutter/material.dart';
import 'package:kopi/ui/pages/main/main_page.dart';
import 'package:kopi/ui/style/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomButtonGetStarted extends StatelessWidget {
  const CustomButtonGetStarted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: EdgeInsets.only(bottom: 30, left: 16, right: 16),
      child: TextButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ));
        },
        style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        child: Text(
          "GET STARTED",
          style: kWhiteTextStyle.copyWith(fontWeight: extraBold),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.onPressed}) : super(key: key);
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 70),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        child: Text(
          "Proses",
          style: kWhiteTextStyle.copyWith(fontWeight: extraBold),
        ),
      ),
    );
  }
}

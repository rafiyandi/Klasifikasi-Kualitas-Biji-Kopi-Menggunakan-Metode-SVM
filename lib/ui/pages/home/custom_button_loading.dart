import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomButtonLoading extends StatelessWidget {
  CustomButtonLoading({
    Key? key,
  }) : super(key: key);

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
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: kWhiteColor,
              ),
            ),
          )),
    );
  }
}

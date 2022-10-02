import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomButtonSlide extends StatelessWidget {
  CustomButtonSlide({
    Key? key,
    required this.controller,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final String text;
  Function() onPressed;

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ));
  }
}

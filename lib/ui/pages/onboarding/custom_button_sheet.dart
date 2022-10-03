import 'package:flutter/material.dart';
import 'package:kopi/ui/pages/onboarding/custom_button_slide.dart';
import 'package:kopi/ui/style/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomButtonSheet extends StatelessWidget {
  const CustomButtonSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // color: kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButtonSlide(
              controller: controller,
              onPressed: () => controller.jumpToPage(2),
              text: "Skip"),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                  spacing: 10,
                  dotWidth: 10,
                  dotHeight: 10,
                  dotColor: Colors.black26,
                  activeDotColor: kPrimaryColor),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn),
            ),
          ),
          CustomButtonSlide(
              controller: controller,
              onPressed: () => controller.nextPage(
                  duration: Duration(microseconds: 500), curve: Curves.easeIn),
              text: "Next")
        ],
      ),
    );
  }
}

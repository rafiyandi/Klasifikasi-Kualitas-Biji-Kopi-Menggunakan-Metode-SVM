import 'package:flutter/material.dart';
import 'package:kopi/ui/pages/onboarding/custom_button_get_started.dart';
import 'package:kopi/ui/pages/onboarding/custom_button_sheet.dart';
import 'package:kopi/ui/pages/onboarding/custom_slider_onboarding.dart';
import 'package:kopi/ui/style/theme.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: PageView(
          onPageChanged: (index) => setState(() {
            isLastPage = index == 2;
          }),
          controller: controller,
          children: [
            CustomSliderOnboarding(
              margin: EdgeInsets.only(top: 100, left: 16, right: 16),
              imgUrl: "assets/image/image_slider1.png",
              titleText: "Welcome",
              text:
                  "You can use this application for coffee bean quality classification",
            ),
            CustomSliderOnboarding(
                margin: EdgeInsets.only(top: 180, left: 16, right: 16),
                imgUrl: "assets/image/image_slider2.png",
                titleText: "Machine Learning",
                text:
                    "In conducting the classification, the researcher uses the Support Vector Machine (SVM) method. SVM is used to find the best hyperplane by maximizing the distance between classes."),
            CustomSliderOnboarding(
              margin: EdgeInsets.only(top: 100, left: 16, right: 16),
              imgUrl: "assets/image/image_slider3.png",
              titleText: "Start App",
              text:
                  "Let's start with the classification of the quality of coffee beans",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? CustomButtonGetStarted()
          : CustomButtonSheet(controller: controller),
    );
  }
}

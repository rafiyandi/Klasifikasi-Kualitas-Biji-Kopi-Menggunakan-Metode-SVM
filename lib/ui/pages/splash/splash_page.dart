import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kopi/ui/style/theme.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInBack);
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          timerSplash();
        }
      },
    );
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  // }

  void timerSplash() {
    Modular.to.pushReplacementNamed("/main");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/44298-coffee-love.json",
              height: 250,
              width: 250,
              controller: _controller,
              repeat: false,
              onLoaded: (composition) {
                _controller.forward();
              },
            ),
            FadeTransition(
              opacity: _animation,
              child: Text(
                "KOPI",
                style: blackTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: medium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

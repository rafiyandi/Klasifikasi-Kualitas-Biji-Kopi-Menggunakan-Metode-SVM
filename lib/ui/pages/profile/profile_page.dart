import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget backgroundImage() {
      return Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/image/image_background_coffe.jpg"),
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 150),
        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff000000).withOpacity(0.20),
              Color(0xff000000).withOpacity(0.95),
            ])),
      );
    }

    Widget profileImage() {
      return Container(
        width: 60,
      );
    }

    return SafeArea(
        child: Stack(
      children: [
        backgroundImage(),
        customShadow(),
      ],
    ));
  }
}

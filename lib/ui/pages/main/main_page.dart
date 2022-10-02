import 'package:flutter/material.dart';
import 'package:kopi/ui/pages/help/help_page.dart';
import 'package:kopi/ui/pages/home/home_page.dart';
import 'package:kopi/ui/pages/main/custom_bottom_navigation_bar.dart';
import 'package:kopi/ui/pages/profile/profile_page.dart';
import 'package:kopi/ui/style/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      switch (_currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return HelpPage();
        case 2:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            buildContent(),
            CustomButtomNavigationBar(
              onChange: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              defaultSelectedIndex: 0,
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:kopi/ui/style/theme.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar(
      {Key? key, this.defaultSelectedIndex = 0, required this.onChange})
      : super(key: key);
  final int defaultSelectedIndex;
  final Function(int) onChange;

  @override
  State<CustomButtomNavigationBar> createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO: default selected index digunakan untuk mengatur default bottom
    _selectedIndex = widget.defaultSelectedIndex;
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget customBottomNavigation(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          //TODO : Onchange diisi nilai index
          widget.onChange(index);
          //TODO: Index merupakan parameter yang menentukan warna dan page
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Icon(
                icon,
                color: index == _selectedIndex ? kPrimaryColor : kGreyColor,
              ),
            ),
            Container(
              width: 32,
              height: 2,
              decoration: BoxDecoration(
                  color: index == _selectedIndex
                      ? kPrimaryColor
                      : kTransparentColor),
            ),
          ],
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customBottomNavigation(
              Icons.home,
              0,
            ),
            customBottomNavigation(
              Icons.library_books,
              1,
            ),
            customBottomNavigation(
              Icons.person,
              2,
            ),
          ],
        ),
      ),
    );
  }
}

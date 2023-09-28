import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:icons_plus/icons_plus.dart';

import '../Theme/style.dart';
import 'history.dart';
import 'home.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _currentIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: const [
          HomePage(),
          HistoryPage(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.all(12),
        backgroundColor: darkRoyalBlue,
        snakeViewColor: cranberry,
        snakeShape: SnakeShape.rectangle,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          bottomTapped(index);
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(IonIcons.home)),
          BottomNavigationBarItem(icon: Icon(FontAwesome.list)),
        ],
      ),
    );
  }
}

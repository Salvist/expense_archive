import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_archive/screens/home_page.dart';
import 'package:money_archive/screens/settings_page.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({
    super.key,
  });

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  final _pageController = PageController(initialPage: 0);

  static const _slideDuration = Duration(milliseconds: 600);
  static const _slideCurves = Curves.easeOutQuart;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_selectedIndex != page) {
        setState(() {
          _selectedIndex = page;
        });
      }
    });
    super.initState();
  }

  void _goToDestination(int index) {
    if (_selectedIndex == index) return;
    _pageController.animateToPage(
      index,
      duration: _slideDuration,
      curve: _slideCurves,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: Platform.isIOS
          ? CupertinoTabBar(
              currentIndex: _selectedIndex,
              onTap: _goToDestination,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings_rounded),
                ),
              ],
            )
          : NavigationBar(
              onDestinationSelected: _goToDestination,
              selectedIndex: _selectedIndex,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                ),
                NavigationDestination(
                  label: 'Settings',
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings_rounded),
                ),
              ],
            ),
    );
  }
}

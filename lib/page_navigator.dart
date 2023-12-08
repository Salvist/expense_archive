import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/repository_provider.dart';
import 'package:simple_expense_tracker/presentation/home/home_provider.dart';
import 'package:simple_expense_tracker/presentation/analytics/analytics_page.dart';
import 'package:simple_expense_tracker/presentation/home/home_page.dart';
import 'package:simple_expense_tracker/screens/settings_page.dart';

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
    final repositoryProvider = RepositoryProvider.of(context);

    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (_selectedIndex != 0) {
          _goToDestination(0);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePageController(
              expenseRepository: repositoryProvider.expenseRepository,
              child: const HomePage(),
            ),
            const AnalyticsPage(),
            const SettingsPage(),
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
                    label: 'Analytics',
                    icon: Icon(Icons.analytics_outlined),
                    activeIcon: Icon(Icons.analytics_rounded),
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
                    label: 'Analytics',
                    icon: Icon(Icons.analytics_outlined),
                    selectedIcon: Icon(Icons.analytics_rounded),
                  ),
                  NavigationDestination(
                    label: 'Settings',
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings_rounded),
                  ),
                ],
              ),
      ),
    );
  }
}

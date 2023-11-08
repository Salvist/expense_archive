import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NavigationRoute {
  home(
    name: 'home',
    path: '/',
    icon: Icons.home_rounded,
  ),
  settings(
    name: 'settings',
    path: '/settings',
    icon: Icons.settings_rounded,
  );

  const NavigationRoute({
    required this.name,
    required this.path,
    required this.icon,
  });

  final String name;
  final String path;
  final IconData icon;
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.child,
  });

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _goToDestination(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 1:
        context.go('/settings');
        break;
      default:
        context.go('/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: widget.child,
      bottomNavigationBar: Platform.isIOS
          ? CupertinoTabBar(
              currentIndex: _selectedIndex,
              onTap: _goToDestination,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                ),
                BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(Icons.settings_rounded),
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

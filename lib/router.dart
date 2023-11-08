import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_archive/screens/add_expense_category_page.dart';
import 'package:money_archive/screens/add_expense_page.dart';
import 'package:money_archive/screens/all_expense_page.dart';
import 'package:money_archive/screens/expense_category_page.dart';
import 'package:money_archive/screens/home_page.dart';
import 'package:money_archive/screens/settings_page.dart';
import 'package:money_archive/widgets/bottom_nav_bar.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'add_expense',
              builder: (context, state) {
                return const AddExpensePage();
              },
            ),
            GoRoute(
              path: 'all_expenses',
              builder: (context, state) {
                return const AllExpensePage();
              },
            )
          ],
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            return const SettingsPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'expense_category',
              builder: (context, state) {
                return const ExpenseCategoryPage();
              },
            ),
            GoRoute(
              path: 'add_expense_category',
              builder: (context, state) {
                return const AddExpenseCategoryPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

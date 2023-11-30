import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_expense_tracker/screens/expense_category/add_expense_category_page.dart';
import 'package:simple_expense_tracker/screens/expense/add_expense_page.dart';
import 'package:simple_expense_tracker/screens/expense/all_expense_page.dart';
import 'package:simple_expense_tracker/screens/expense_category/expense_category_page.dart';
import 'package:simple_expense_tracker/screens/home_page.dart';
import 'package:simple_expense_tracker/screens/settings_page.dart';
import 'package:simple_expense_tracker/widgets/bottom_nav_bar.dart';

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

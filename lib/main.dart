import 'package:flutter/material.dart';
import 'package:money_archive/page_navigator.dart';
import 'package:realm/realm.dart';
import 'package:money_archive/data/local/realm/models/expense.dart';
import 'package:money_archive/data/local/realm/models/expense_category.dart';
import 'package:money_archive/data/local/realm/repositories/expense_category_repository.dart';
import 'package:money_archive/data/local/realm/repositories/expense_repository.dart';
import 'package:money_archive/providers/expense_category_provider.dart';
import 'package:money_archive/providers/expenses_provider.dart';
import 'package:money_archive/router.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  final realmConfig = Configuration.local(
    [
      RealmExpense.schema,
      RealmExpenseCategory.schema,
    ],
    shouldDeleteIfMigrationNeeded: true,
  );
  final realm = Realm(realmConfig);

  final expenseRepository = RealmExpenseRepository(realm);
  final categoryRepository = RealmExpenseCategoryRepository(realm);

  runApp(
    ExpenseProvider(
      repository: expenseRepository,
      child: ExpenseCategoryProvider(
        repository: categoryRepository,
        child: const MoneyArchiveApp(),
      ),
    ),
  );
}

class MoneyArchiveApp extends StatelessWidget {
  const MoneyArchiveApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Archive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        // fontFamily: GoogleFonts.robotoSlab().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
          ),
        ),
      ),
      home: const PageNavigator(),
    );

    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    //     useMaterial3: true,
    //     // fontFamily: GoogleFonts.robotoSlab().fontFamily,
    //     inputDecorationTheme: const InputDecorationTheme(
    //       filled: true,
    //     ),
    //     dropdownMenuTheme: const DropdownMenuThemeData(
    //       inputDecorationTheme: InputDecorationTheme(
    //         filled: true,
    //       ),
    //     ),
    //   ),
    //   routerConfig: router,
    // );
  }
}

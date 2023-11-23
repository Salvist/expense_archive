import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_expense_tracker/data/local/realm/models/business.dart';
import 'package:simple_expense_tracker/data/local/realm/models/expense.dart';
import 'package:simple_expense_tracker/data/local/realm/models/expense_category.dart';
import 'package:simple_expense_tracker/data/local/realm/repositories/business_repository.dart';
import 'package:simple_expense_tracker/data/local/realm/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/data/local/realm/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/page_navigator.dart';
import 'package:simple_expense_tracker/providers/business_provider.dart';
import 'package:simple_expense_tracker/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/providers/expenses_provider.dart';
import 'package:realm/realm.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  final realmConfig = Configuration.local(
    [
      RealmExpense.schema,
      RealmExpenseCategory.schema,
      RealmBusiness.schema,
    ],
    shouldDeleteIfMigrationNeeded: true,
  );
  final realm = Realm(realmConfig);
  // realm.close();
  // Realm.deleteRealm(realmConfig.path);

  final expenseRepository = RealmExpenseRepository(realm);
  final categoryRepository = RealmExpenseCategoryRepository(realm);
  final businessesRepository = RealmBusinessRepository(realm);

  runApp(
    ExpenseProvider(
      repository: expenseRepository,
      child: ExpenseCategoryProvider(
        repository: categoryRepository,
        child: BusinessProvider(
          repository: businessesRepository,
          child: const ExpenseArchiveApp(),
        ),
      ),
    ),
  );
}

class ExpenseArchiveApp extends StatelessWidget {
  const ExpenseArchiveApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Archive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.manrope().fontFamily,
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

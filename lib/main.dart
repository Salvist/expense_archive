import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_expense_tracker/data/repositories/business_repository.dart';
import 'package:simple_expense_tracker/data/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/data/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/data/shared_preferences_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/business.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/expense.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/expense_category.dart';
import 'package:simple_expense_tracker/data/source/local/realm/repositories/business_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
import 'package:simple_expense_tracker/page_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  final realmSchemas = [
    RealmExpense.schema,
    RealmExpenseCategory.schema,
    RealmBusiness.schema,
  ];

  final realmConfig = Configuration.local(
    realmSchemas,
    shouldDeleteIfMigrationNeeded: true,
  );
  final realm = Realm(realmConfig);
  // realm.close();
  // Realm.deleteRealm(realmConfig.path);

  // Local repositories
  final localExpenseRepo = RealmExpenseRepository(realm);
  final localCategoryRepo = RealmExpenseCategoryRepository(realm);
  final localBusinessRepo = RealmBusinessDataSource(realm);
  final sharedPrefsRepo = SharedPreferencesRepositoryImpl(await SharedPreferences.getInstance());
  sharedPrefsRepo.setAskOnRemoveCategory(true);

  // Domain repositories
  final expenseRepository = ExpenseRepositoryImpl(localExpenseRepo);
  final categoryRepository = ExpenseCategoryRepositoryImpl(localCategoryRepo);
  final businessRepository = BusinessRepositoryImpl(localBusinessRepo);

  runApp(
    RepositoryProvider(
      expenseRepository: expenseRepository,
      categoryRepository: categoryRepository,
      businessRepository: businessRepository,
      sharedPreferencesRepository: sharedPrefsRepo,
      child: const ExpenseArchiveApp(),
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
  }
}

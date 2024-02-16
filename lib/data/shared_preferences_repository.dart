import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_expense_tracker/domain/repositories/shared_preferences_repository.dart';
import 'dart:developer' as dev;

const _isFirstTimeKey = 'isFirstTime';
const _askOnRemoveCategoryKey = 'askOnRemoveCategory';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  final SharedPreferences _prefs;
  const SharedPreferencesRepositoryImpl(this._prefs);

  @override
  bool isFirstTime() {
    final isFirstTime = _prefs.getBool(_isFirstTimeKey) ?? true;
    _prefs.setBool(_isFirstTimeKey, false);
    dev.log('Is first time starting the app? $isFirstTime', name: 'SharedPreferences');
    return isFirstTime;
  }

  @override
  bool askOnRemoveCategory() {
    return _prefs.getBool(_askOnRemoveCategoryKey) ?? true;
  }

  @override
  void setAskOnRemoveCategory(bool value) {
    _prefs.setBool(_askOnRemoveCategoryKey, value);
  }
}

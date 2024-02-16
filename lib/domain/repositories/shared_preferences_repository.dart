abstract interface class SharedPreferencesRepository {
  const SharedPreferencesRepository();

  bool askOnRemoveCategory();
  void setAskOnRemoveCategory(bool value);

  bool isFirstTime();
}

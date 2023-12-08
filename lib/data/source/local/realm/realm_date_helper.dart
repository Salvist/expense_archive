class RealmDateHelper{
  const RealmDateHelper._();

  /// Converts dart DateTime into date query string.
  static String getMonthDate(DateTime date){
    final month = '${date.month}'.padLeft(2, '0');
    return '${date.year}-$month-01';
  }

}
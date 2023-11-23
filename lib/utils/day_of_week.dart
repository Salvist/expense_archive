enum DayOfWeek {
  sunday('Sunday', 'Sun'),
  monday('Monday', 'Mon'),
  tuesday('Tuesday', 'Tue'),
  wednesday('Wednesday', 'Wed'),
  thursday('Thursday', 'Thu'),
  friday('Friday', 'Fri'),
  saturday('Saturday', 'Sat');

  final String fullName;
  final String shortName;
  const DayOfWeek(this.fullName, this.shortName);
}

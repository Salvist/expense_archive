extension NumberRounder on num {
  int roundWithStep(int step) {
    if (this % step == 0) return round();
    final numOfStep = this ~/ step + 1;
    return numOfStep * step;
  }

  int nearestHundred() {
    return roundWithStep(100);
  }
}

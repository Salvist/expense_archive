import 'package:flutter/material.dart' show IconData;

IconData? getIconData(int? codePoint) {
  if (codePoint == null) return null;
  return IconData(codePoint, fontFamily: 'MaterialIcons');
}

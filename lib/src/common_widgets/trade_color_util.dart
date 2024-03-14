import 'package:flutter/material.dart';

class TextColorUtil {
  static Color calculateTextColor(String text) {
    double textValue = double.parse(text);
    
    if (textValue < 0) {
      return Colors.red;
    } else if (textValue == 0) {
      return Colors.black;
    } else {
      return Colors.blue;
    }
  }
}
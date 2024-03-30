import 'package:flutter/material.dart';

double height = 0;
double width = 0;

extension ScreenWidth on num {
  double screenWidth() {

    return (this / 375) * width;
  }
}

extension TextSize on num {
  double textSize() {
    return this / (812 + 375) * (height + width);
  }
}

extension ScreenHeight on num {
  double screenHeight() {
    return (this / 812) * height;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
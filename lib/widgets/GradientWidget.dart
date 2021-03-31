import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGradientWidget {
  LinearGradient linear(
      {AlignmentGeometry start: Alignment.topLeft,
      AlignmentGeometry end: Alignment.bottomRight,
      Color startColor,Color endColor}) {
    return LinearGradient(
        begin: start,
        end: end,
        colors: [startColor??Get.theme.backgroundColor, endColor??Get.theme.accentColor]);
  }
}

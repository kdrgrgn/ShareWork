
import 'package:flutter/material.dart';
import 'package:mobi/widgets/GradientWidget.dart';

class CircleGradientContainer extends StatelessWidget {
  Widget icon;

  CircleGradientContainer(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MyGradientWidget().linear(),
        borderRadius: BorderRadius.circular(30)
      ),
      child: icon,
    );
  }
}



import 'package:flutter/material.dart';
import 'package:mobi/widgets/GradientWidget.dart';

class ButtonGradient extends StatelessWidget {
  Widget child;

  ButtonGradient(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          gradient: MyGradientWidget().linear(),
          borderRadius: BorderRadius.circular(30)
      ),
      child: child,
    );
  }
}

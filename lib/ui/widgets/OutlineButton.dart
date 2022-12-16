import 'package:flutter/material.dart';

import '../const/Constants.dart';

class MyOutlineButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onButtonClick;
  Color colors;
  double radius;
  double horizontalMargin;

  MyOutlineButton(
      {super.key,
      required this.label,
      required this.onButtonClick,
      this.colors = Colors.white,
      this.horizontalMargin = 40.0,
      this.radius = kButtonCornerRadius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          // shape: BoxShape.rectangle,
          border: Border.all(color: colors, width: kButtonStrokeWidth),
          borderRadius: BorderRadius.circular(radius),
          // border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: colors, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

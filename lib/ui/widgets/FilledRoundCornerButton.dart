import 'package:flutter/material.dart';

import '../const/Constants.dart';

class MyFilledRoundCornerButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onButtonClick;
  double radius;
  double horizontalPadding = 40.0;

  MyFilledRoundCornerButton({
    super.key,
    required this.label,
    required this.onButtonClick,
    this.horizontalPadding = 40.0,
    this.radius = kButtonCornerRadius,
  });


  @override
  Widget build(BuildContext context) {
    print("HORIXONTAL PADDING: $horizontalPadding");
    return InkWell(
      onTap: onButtonClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        // width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue,
          // border: Border.all(color: Colors.white, width: kButtonStrokeWidth),
          borderRadius: BorderRadius.circular(radius),
          // border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

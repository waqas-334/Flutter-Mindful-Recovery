import 'package:flutter/material.dart';

import '../const/Constants.dart';

class MyOutlineButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onButtonClick;

  const MyOutlineButton(
      {super.key, required this.label, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonClick,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          // shape: BoxShape.rectangle,
          border: Border.all(color: Colors.white, width: kButtonStrokeWidth),
          borderRadius: BorderRadius.circular(kButtonCornerRadius),
          // border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

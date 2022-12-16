import 'package:flutter/material.dart';
const kBackButton = MyBackButton();
class MyBackButton extends StatelessWidget {
  // const BackButton({Key? key}) : super(key: key);
  // GestureTapCallback? onClick;
  // Icon icon;
  // MyBackButton({this.onClick, super.key, this.icon = const Icon(Icons.arrow_back_ios)});
  const MyBackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.of(context).pop();},
      child: const Icon(Icons.arrow_back_ios),
    );
  }
}

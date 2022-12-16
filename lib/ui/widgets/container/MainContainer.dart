import 'package:flutter/material.dart';

import '../appbar content/AppBarConstants.dart';

class MainContainer extends StatelessWidget {
  List<Widget> children;

  MainContainer({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    var heightOfStatusBar = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - heightOfStatusBar - 32;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: height,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kAppBar,
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

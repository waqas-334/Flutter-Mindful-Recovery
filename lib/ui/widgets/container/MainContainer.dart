import 'package:flutter/material.dart';

import '../appbar content/AppBarConstants.dart';

class MainContainer extends StatelessWidget {
  List<Widget> children;
  Widget? appBar;
  double? padding;

  MainContainer({required this.children, super.key, this.appBar, this.padding});

  @override
  Widget build(BuildContext context) {
    var heightOfStatusBar = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - heightOfStatusBar - 32;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(padding??16.0),
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
                    appBar ?? kAppBar,
                    // appBar == null?kAppBar,
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

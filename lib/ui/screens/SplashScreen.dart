import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/MainScreen.dart';
import 'package:flutter_mindful_recovery/ui/screens/PrivacyPolicyScreen.dart';

import '../widgets/OutlineButton.dart';

final Uri _privacy_policy = Uri.parse(kPrivacyPolicyUrl);

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String app_icon = "assets/images/app_icon.png";

    Widget appIconAndTagLine = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          app_icon,
          scale: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Think before you eat",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Align(child: appIconAndTagLine),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "By continuing you are agreeing to "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(context);
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyOutlineButton(
                    label: "Lets Go",
                    onButtonClick: () {
                      letsGoClicked(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchUrl(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MyWebView()));
  }

  void letsGoClicked(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainScreen()));
  }

//
// Future<void> _launchUrl() async {
//   if (!await launchUrl(_privacy_policy, mode: LaunchMode.inAppWebView)) {
//     throw 'Could not launch $_privacy_policy';
//   }
// }
}

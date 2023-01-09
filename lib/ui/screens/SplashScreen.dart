import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/MainScreen.dart';
import 'package:flutter_mindful_recovery/ui/screens/PrivacyPolicyScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/OutlineButton.dart';

final Uri _privacy_policy = Uri.parse(kPrivacyPolicyUrl);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? newLaunch;
  late SharedPreferences prefs;

  @override
  void initState() {
    loadNewLaunch();
  }

  loadNewLaunch() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _newLaunch = ((prefs.getBool('newLaunch') ?? true));
      newLaunch = _newLaunch;
      if(newLaunch==false){
        goToMainActivity(context);
      }
    });
  }

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
          "Self Care Check Check In.",
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MyWebView(kPrivacyPolicyUrl)));
  }

  void letsGoClicked(context) async {
    goToMainActivity(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("newLaunch", false);
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  void goToMainActivity(context) {
    Navigator.pushReplacementNamed(context, MainScreen.routeName);
  }
}

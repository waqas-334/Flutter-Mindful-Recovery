import 'package:flutter/cupertino.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../widgets/FilledRoundCornerButton.dart';
import '../widgets/appbar content/AppBarConstants.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(appBar: Container(), children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/yaay.png",
            scale: 3,
          ),
        ],
      ),
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Great",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Your data has been recorded"),
        ],
      ),
      Spacer(),
      MyFilledRoundCornerButton(
        label: "Go to Main Menu",
        onButtonClick: () {
          _continueClicked(context);
        },
        horizontalPadding: 0.0,
      )
    ]);
  }

  void _continueClicked(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName("/main"));
  }
}

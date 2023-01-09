import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '16. Gratefull For Screen.dart';
import '6. Physical Hunger Screen.dart';

enum MoreInfo {
  Urinated,
  BowelMovement,
}

class BathRoomBreak extends StatefulWidget {
  Record? record;

  BathRoomBreak(this.record, {Key? key}) : super(key: key);

  @override
  State<BathRoomBreak> createState() => _BathRoomBreakState();
}

class _BathRoomBreakState extends State<BathRoomBreak> {
  YesOrNo? hadBathroomBreak = null;
  MoreInfo? moreInfo = null;

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("Have I taken a bathroom break:", style: kQuestionTextStyle),
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: hadBathroomBreak,
          onChanged: onRadioChanged,
        ),
      ),
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.NO);
        },
        title: Text("No"),
        leading: Radio(
          value: YesOrNo.NO,
          groupValue: hadBathroomBreak,
          onChanged: onRadioChanged,
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      if (hadBathroomBreak == YesOrNo.YES) ...[
        const Text("More Info:", style: kQuestionTextStyle),
        kSizedBox10,
        ListTile(
          onTap: () {
            onRadioChanged2(MoreInfo.Urinated);
          },
          title: Text("Urinated"),
          leading: Radio(
            value: MoreInfo.Urinated,
            groupValue: moreInfo,
            onChanged: onRadioChanged2,
          ),
        ),
        ListTile(
          onTap: () {
            onRadioChanged2(MoreInfo.BowelMovement);
          },
          title: Text("Bowel Movement"),
          leading: Radio(
            value: MoreInfo.BowelMovement,
            groupValue: moreInfo,
            onChanged: onRadioChanged2,
          ),
        ),
      ],
      Spacer(),
      MyFilledRoundCornerButton(
        label: "Continue",
        onButtonClick: _continueClicked,
        horizontalPadding: 0.0,
      ),
    ]);
  }

  void onRadioChanged(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      hadBathroomBreak = value;
    });
  }

  void onRadioChanged2(MoreInfo? value) {
    if (value == null) return;
    setState(() {
      moreInfo = value;
    });
  }

  void _continueClicked() {
    if (hadBathroomBreak == null) {
      showErrorToast();
      return;
    }

    if(hadBathroomBreak==YesOrNo.YES && moreInfo==null){
      showErrorToast();
      return;
    }

    widget.record?.bathroom_break = hadBathroomBreak?.toShortString();
    widget.record?.bathroom_break_more_info =
        moreInfo?.toString().split(".").last; //TODO IMPROVE THIS

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GrateFullForScreen(widget.record)));
  }
}

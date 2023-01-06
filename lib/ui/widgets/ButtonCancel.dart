import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/widgets/OutlineButton.dart';

import 'FilledRoundCornerButton.dart';

const kCancelButton = CancelButton();

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizedBox10,
                      const Text(
                        "Are you sure?",
                        style: TextStyle(fontSize: 25),
                      ),
                      kSizedBox10,
                      kSizedBox10,
                      const Text(
                          "The progress you have made so far will be removed"),
                      kSizedBox10,
                      kSizedBox10,
                      MyOutlineButton(
                        label: "Cancel",
                        onButtonClick: () {
                          Navigator.pop(context);
                        },
                        colors: Colors.blue,
                      ),
                      kSizedBox10,
                      MyFilledRoundCornerButton(
                        label: 'Yes',
                        onButtonClick: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName("/main"));
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.clear),
    );
  }
}

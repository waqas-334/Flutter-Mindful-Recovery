import 'package:flutter/cupertino.dart';

import '../ButtonBack.dart';
import '../ButtonCancel.dart';

Widget kAppBar = Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: const [
    kBackButton,
    kCancelButton,
  ],
);

Widget kAppBarWithJustBackButton = Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: const [
    kBackButton,
  ],
);

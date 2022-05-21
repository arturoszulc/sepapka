import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../utils/consts/colors.dart';

GroupButtonOptions myGroupButtonOptions() {
  return const GroupButtonOptions(
    textPadding: EdgeInsets.symmetric(horizontal: 5.0,),
    spacing: 10.0,
    // selectedColor: myPrimary,
    // selectedTextStyle: TextStyle(color: mySecondary),
    // unselectedTextStyle: TextStyle(color: mySecondary),
    // mainGroupAlignment: MainGroupAlignment.spaceEvenly,

  );
}
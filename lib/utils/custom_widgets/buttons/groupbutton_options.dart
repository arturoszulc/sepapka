import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:sepapka/utils/consts/colors.dart';

GroupButtonOptions myGroupButtonOptions(BuildContext context) {
  return GroupButtonOptions(
    textPadding: const EdgeInsets.symmetric(horizontal: 5.0,),
    spacing: 10.0,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    selectedTextStyle: TextStyle(color: flexSchemeLight.onPrimary),
    unselectedColor: Colors.white,
    // mainGroupAlignment: MainGroupAlignment.spaceEvenly,

  );
}

GroupButtonOptions myGroupButtonOptions2(double width) {
  //Size in physical pixels

  return const GroupButtonOptions(
buttonWidth: 100,
    textPadding: EdgeInsets.symmetric(horizontal: 5.0,),
    spacing: 10.0,
    buttonHeight: 100,
    // selectedColor: myPrimary,
    // selectedTextStyle: TextStyle(color: mySecondary),
    // unselectedTextStyle: TextStyle(color: mySecondary),
    // mainGroupAlignment: MainGroupAlignment.spaceEvenly,

  );
}


GroupButtonOptions unitGroupButtonOptions(BuildContext context) {
  return GroupButtonOptions(
    unselectedTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 12),
    // textPadding: const EdgeInsets.symmetric(horizontal: 5.0,),
    // spacing: 10.0,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    selectedTextStyle: TextStyle(color: flexSchemeLight.onPrimary, fontSize: 12),
    // unselectedColor: Colors.white,
    // mainGroupAlignment: MainGroupAlignment.spaceEvenly,

  );
}
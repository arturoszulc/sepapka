import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel_layer/manager.dart';
import '../../utils/consts/nav.dart';

Widget? unlockButton(BuildContext context) {
  bool isUserPro = context.read<Manager>().loggedUser!.isPro;
  return isUserPro ? null : FloatingActionButton.extended(onPressed: () {
    context.read<Manager>().revenueCatStart();
  }, label: Row(
    children: const [
      Text('Odblokuj wszystko'),
      SizedBox(width: 5),
      Icon(Icons.lock_open, size: 16,),
    ],
  ),);
}
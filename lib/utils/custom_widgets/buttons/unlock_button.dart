import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts/my_screens.dart';

import '../../../viewmodel_layer/manager.dart';

Widget? unlockButton(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) =>
    // ref.read(userService).isPro
    //     ? Container()
    //     :
    FloatingActionButton.extended(
            onPressed: () {
              context.pushNamed(MyScreen.purchaseWrapper.name);
            },
            label: Row(
              children: const [
                Text('Odblokuj wszystko'),
                SizedBox(width: 5),
                Icon(
                  Icons.lock_open,
                  size: 16,
                ),
              ],
            ),
          ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel_layer/manager.dart';

Widget? unlockButton(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) => ref.read(manager).loggedUser!.isPro
        ? Container()
        : FloatingActionButton.extended(
            onPressed: () {
              ref.read(manager).revenueCatStart();
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

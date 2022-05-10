import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';

class PurchaseError extends StatelessWidget {
  const PurchaseError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.chooseLevel),
    child: Scaffold(
    appBar: AppBar(
    leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => context.read<Manager>().navigate(Screen.chooseLevel),
    ),
    title: const Text('Purchase Error'),
    centerTitle: true,
    ),


    ));
  }
}

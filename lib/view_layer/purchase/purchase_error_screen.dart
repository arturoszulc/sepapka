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
    // title: const Text('Purchase Error'),
    // centerTitle: true,
    ),
    body: Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
      Icon(Icons.error, size: 36, color: Colors.red,),
      SizedBox(height: 10,),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Coś poszło nie tak...\nSprawdź połączenie z internetem i spróbuj ponownie', textAlign: TextAlign.center,),
      ),
    ],),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          context.read<Manager>().navigate(Screen.menu);
        }, label: const Text('Powrót do menu'),),

    ));
  }
}

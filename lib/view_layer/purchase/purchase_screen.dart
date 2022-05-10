
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Purchase Screen built');
    final manager = Provider.of<Manager>(context);
    return WillPopScope(
      onWillPop: () => context.read<Manager>().closeStore(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().closeStore(),
          ),
          title: const Text('Odblokuj pytania'),
          centerTitle: true,
        ),

        body: const Center(child: Text('PurchaseScreen')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(onPressed: () {
          manager.buyProduct();
        }, label: Text('Kup za ${manager.productPrice} zł')),
      ),
    );
  }
}

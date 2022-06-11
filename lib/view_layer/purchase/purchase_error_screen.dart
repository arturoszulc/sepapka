import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';

class PurchaseError extends StatelessWidget {
  const PurchaseError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(MyScreen.menu),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<Manager>().navigate(MyScreen.menu),
            ),
            // title: const Text('Purchase Error'),
            // centerTitle: true,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 60,
                      color: Colors.red,
                    ),
                    Text('Coś poszło nie tak...', style: Theme.of(context).textTheme.headline4),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sprawdź połączenie z internetem i spróbuj ponownie',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text('Szczegóły błędu:'),
                Text(context.read<Manager>().purchaseError.toString()),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<Manager>().navigate(MyScreen.menu);
            },
            label: const Text('Powrót do menu'),
          ),
        ));
  }
}

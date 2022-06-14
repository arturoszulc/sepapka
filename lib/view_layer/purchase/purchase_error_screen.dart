import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/consts/my_screens.dart';
import '../../viewmodel_layer/manager.dart';

class PurchaseError extends StatelessWidget {
  const PurchaseError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                    Text(ref.read(manager).purchaseError.toString())),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer(

        builder: (BuildContext context, WidgetRef ref, Widget? child) => FloatingActionButton.extended(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            ref.read(manager).navigate(MyScreen.menu);
          },
          label: const Text('Powrót do menu'),
        ),
      ),
    );
  }
}

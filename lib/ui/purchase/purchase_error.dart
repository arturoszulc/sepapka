import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/controllers/purchase_Controller.dart';

class PurchaseError extends ConsumerWidget {
  const PurchaseError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 7,
              child: buildErrorDetails(context, ref.read(purchaseController).error)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: FloatingActionButton.extended(
              backgroundColor: proColor,
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                ref.refresh(purchaseController);
                // context.goNamed(MyScreen.menu.name);
              },
              label: const Text('Spróbuj ponownie'),
            ),
          ),
        ],
      ),
    );
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // floatingActionButton:
  }

  Widget buildErrorDetails(BuildContext context, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.error,
              size: 60,
              color: proColor,
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
        Text(details)
      ],
    );
  }
}

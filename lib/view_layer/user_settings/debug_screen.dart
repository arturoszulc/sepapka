import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    debugPrint('*** Debug Screen built ***');

    String product = Provider.of<Manager>(context).productName;
    bool isAvailable = Provider.of<Manager>(context).isAvailable;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.read<Manager>().navigate(Screen.menu),
        ),
        title: const Text('DEBUG'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),

            Text('LoggedUser ID: ${context
                .read<Manager>()
                .loggedUser!
                .documentId}'),
            const SizedBox(height: 10),
            Text('Widoczne pytania: ${context
                .read<Manager>()
                .loggedUser!
                .qListNew
                .length}'),
            Text(
                'Ukryte pytania: ${context
                    .read<Manager>()
                    .loggedUser!
                    .qListNotShown
                    .length}'),
            const SizedBox(height: 10),
            Text('LoggedUser.isPro: ${context
                .read<Manager>()
                .loggedUser!
                .isPro
                .toString()}'),
            const SizedBox(height: 20.0),

            MenuButton(
              label: context
                  .read<Manager>()
                  .loggedUser!
                  .isPro ? 'Go FREE' : 'Go PRO',
              onPressed: () async {
                var result = await goProDialog(context);
                if (result) {
                  await context.read<Manager>().goPro(!context
                    .read<Manager>()
                    .loggedUser!
                    .isPro);
                }
              },),
            MenuButton(
              label: 'get products',
              onPressed: () async {
                // await context.read<Manager>().checkIfStoreIsAvailable();
                // await context.read<Manager>().getUserProducts();
              },),
            Text('Is Available: ${isAvailable.toString()}'),
            Text('Product:$product'),
            MenuButton(
              label: 'buy product',
              onPressed: () async {
                await context.read<Manager>().buyProduct();
              },),
          ],
        ),
      ),
    );
  }

  // DELETE THIS WIDGET RIGHT AFTER DELETING GO PRO/FREE BUTTON

  Future goProDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Czy na pewno chcesz to zrobić?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(false);
                },
                child: const Text('Nie'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(true);
                },
                child: const Text('Tak'),
              ),
            ],
          ),
    );
  }
}

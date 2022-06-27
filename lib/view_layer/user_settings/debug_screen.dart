import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/my_screens.dart';


class DebugScreen extends ConsumerWidget {
  const DebugScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** Debug Screen built ***');

    final myManager = ref.read(manager);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(MyScreen.menu.name),
        ),
        title: const Text('DEBUG'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),

            Text('LoggedUser ID: ${myManager
                .loggedUser!
                .documentId}'),
            const SizedBox(height: 10),
            Text('Widoczne pytania: ${myManager
                .loggedUser!
                .qListNew
                .length}'),
            Text(
                'Ukryte pytania: ${myManager
                    .loggedUser!
                    .qListNotShown
                    .length}'),
            const SizedBox(height: 10),
            Text('LoggedUser.isPro: ${myManager
                .loggedUser!
                .isPro
                .toString()}'),
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

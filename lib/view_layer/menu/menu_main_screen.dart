import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/nav_manager.dart';
import 'package:sepapka/utils/consts/nav.dart';
import '../custom_widgets/progress_bar_global.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    int howManyToPractice = context.read<Manager>().howManyToPracticeToday;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text(
                'Witaj, ${context.read<Manager>().loggedUser!.username}',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                  onPressed: () {
                    context.read<Manager>().navigate(Screen.settings);
                    // Navigator.pushNamed(context, '/settings-screen');
                  },
                  icon: const Icon(Icons.account_circle)),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/menu-choose-level');
                          },
                          child: const Text('Nauka'),
                        ),
                        ElevatedButton(
                          onPressed: howManyToPractice == 0
                              ? null
                              : () async {
                                  await context.read<Manager>().startPractice();
                                  Navigator.pushNamed(context, '/question-single');
                                },
                          child: Text('Powtórka materiału ($howManyToPractice)'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/question-list');
                          },
                          child: Text('Lista pytań'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Text('LoggedUser ID: ${context.read<Manager>().loggedUser!.documentId}'),
            Text('LoggedUser qNew1: ${context.read<Manager>().loggedUser!.qListNew1.length}'),
            Text('LoggedUser qNew2: ${context.read<Manager>().loggedUser!.qListNew2.length}'),
            Text('LoggedUser qNew3: ${context.read<Manager>().loggedUser!.qListNew3.length}'),
            Text(
                'LoggedUser qPractice: ${context.read<Manager>().loggedUser!.qListPractice.length}'),
            Text(
                'LoggedUser qNotShown: ${context.read<Manager>().loggedUser!.qListNotShown.length}'),
            Text(
                'LoggedUser is Pro: ${context.read<Manager>().loggedUser!.isPro.toString()}'),

            const SizedBox(height: 100.0),
            buildProgressBar(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

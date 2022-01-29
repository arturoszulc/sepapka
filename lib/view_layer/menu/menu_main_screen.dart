import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../custom_widgets/progress_bar_global.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    int howManyToPractice = context.read<Manager>().howManyToPracticeToday;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings-screen');
              },
              icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
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
                          onPressed: () async {
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
            Text('LoggedUser qPractice: ${context.read<Manager>().loggedUser!.qListPractice.length}'),
            Text('LoggedUser qNotShown: ${context.read<Manager>().loggedUser!.qListNotShown.length}'),
            const SizedBox(height: 100.0),
            buildProgressBar(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../custom_widgets/progress_bar.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

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
                          onPressed: () async {
                            await context.read<Manager>().prepareQuestion(QuestionType.newQuestion);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Nauka'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await context.read<Manager>().prepareQuestion(QuestionType.practiceQuestion);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Powtórka materiału'),
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
            Text('LoggedUser qNew: ${context.read<Manager>().loggedUser!.qListNew.length}'),
            Text('LoggedUser qPractice: ${context.read<Manager>().loggedUser!.qListPractice.length}'),
            const SizedBox(height: 100.0),
            buildProgressBar(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

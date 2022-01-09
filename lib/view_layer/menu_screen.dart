import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(

              onPressed: () async {
                await context.read<Manager>().prepareNewQuestion();
                Navigator.pushNamed(context, '/question-single');
              },
              child: const Text('Nauka'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<Manager>().preparePracticeQuestion();
                // Navigator.pushNamed(context, '/question-single');
              },
              child: const Text('Powtórka materiału'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/question-list');
              },
              child: Text('Lista pytań'),
            ),
            Text('LoggedUser ID: ${context.read<Manager>().loggedUser!.documentId}'),
            Text('LoggedUser qNewList: ${context.read<Manager>().loggedUser!.qListNew}'),
            Text('LoggedUser qPracticeList: ${context.read<Manager>().loggedUser!.qListPractice}'),
            Text('LoggedUser qNotShownList: ${context.read<Manager>().loggedUser!.qListNotShown}'),


          ],
        ),
      ),
    );
  }
}

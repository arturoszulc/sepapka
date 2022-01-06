import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    final manager = Provider.of<Manager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/question-list');
              },
              child: Text('Lista pytań'),
            ),
            ElevatedButton(

              onPressed: () async {
                await manager.prepareSingleQuestion();
                Navigator.pushNamed(context, '/question-single');
              },
              child: Text('Losowe pytanie'),
            ),
            Text('LoggedUser ID: ${manager.loggedUser!.documentId}'),
            Text('LoggedUser qNew: ${manager.loggedUser!.qListNew}'),
            Text('LoggedUser qKnown: ${manager.loggedUser!.qListDeleted}'),
            Text('LoggedUser qUnknown: ${manager.loggedUser!.qListPractice}'),

          ],
        ),
      ),
    );
  }
}

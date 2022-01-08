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
                await context.read<Manager>().prepareNewQuestion();
                Navigator.pushNamed(context, '/question-single');
              },
              child: Text('Losowe pytanie'),
            ),
            Text('LoggedUser ID: ${context.read<Manager>().loggedUser!.documentId}'),


          ],
        ),
      ),
    );
  }
}

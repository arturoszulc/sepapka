import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Settings built ***');

    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen'),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<Manager>().resetUserProgress();
                // manager.addQuestionsToDb();
              },
              child: const Text('Reset User Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<Manager>().signOut();
                Navigator.pop(context);
                // manager.addQuestionsToDb();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Settings built ***');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/wrapper', (Route<dynamic> route) => false),
        ),
        title: const Text('Settings Screen'),

      ),
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/wrapper', (Route<dynamic> route) => false);
          }, label: const Text('Zapisz')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Settings built ***');

    //TODO: Consider how to handle going back from this screen - when to save, when to discard, when to rebuild main screen

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
        //       '/wrapper', (Route<dynamic> route) => false),
        // ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
            },
            child: const Text(
              'Zapisz',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        title: const Text('Settings Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<Manager>().resetUserProgress();
              },
              child: const Text('Reset User Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<Manager>().signOut();
                Navigator.pop(context);
                // context.read<Manager>().addQuestionsToDb(isPro: false);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
      //   },
      //   label: const Text('Zapisz'),
      // ),
    );
  }
}

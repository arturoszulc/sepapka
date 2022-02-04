import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  // final _userDataForm = GlobalKey<FormState>();

  // bool usernameChanged = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Settings Screen built ***');

    //TODO: Consider how to handle going back from this screen - when to save, when to discard, when to rebuild main screen
    // final manager = Provider.of<Manager>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
            },
            child: const Text(
              'Zapisz',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        title: const Text('Profil użytkownika'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: context.read<Manager>().loggedUser!.username,
                    // controller: emailFieldController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nazwa użytkownika',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings-change-user-data');
                  },
                  icon: const Icon(Icons.edit),
                )

                // const Text('Nazwa użytkownika'),
                // Container(
                //   margin: EdgeInsets.only(top: 10.0),
                //     padding: const EdgeInsets.all(10.0),
                //     decoration: BoxDecoration(
                //       border: Border.all(),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: Text(context.read<Manager>().loggedUser!.username)),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text('Liczba punktów: ${context.read<Manager>().loggedUser!.rankTotalPoints}'),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              context.read<Manager>().goPro();
            },
            child: const Text('Go PRO'),
          ),
          const SizedBox(height: 20.0),
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

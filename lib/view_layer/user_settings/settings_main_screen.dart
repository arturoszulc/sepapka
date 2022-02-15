import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/global_data.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/view_layer/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  // final _userDataForm = GlobalKey<FormState>();

  // bool usernameChanged = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Settings Screen built ***');

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.menu),
          ),
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
                      context.read<Manager>().navigate(Screen.changeUserName);
                      // Navigator.pushNamed(context, '/settings-change-user-data');
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
            Text('Twoja ranga: ${context.read<Manager>().userRankName}'),
            Text('Liczba punktów: ${context.read<Manager>().loggedUser!.rankTotalPoints}'),
            const SizedBox(height: 20.0),
            MenuButton(
                label: context.read<Manager>().loggedUser!.isPro ? 'Go FREE' : 'Go PRO',
                onPressed: () async {
                  var result = await goProDialog(context);
                  if (result) await context.read<Manager>().goPro(!context.read<Manager>().loggedUser!.isPro);
                },),
            const SizedBox(height: 20.0),
            MenuButton(label: 'Reset User Data', onPressed: () {
              context.read<Manager>().resetUserProgress();
            },),
            MenuButton(label: 'Sign Out', onPressed: () async {
              await context.read<Manager>().signOut();
              // context.read<Manager>().addQuestionsToDb(isPro: false);
            },)
            // ElevatedButton(
            //   onPressed: () async {
            //     var result = await goProDialog(context);
            //     if (result) await context.read<Manager>().goPro(!context.read<Manager>().loggedUser!.isPro);
            //     // Navigator.pop(context);
            //   },
            //   child: context.read<Manager>().loggedUser!.isPro ? const Text('Go FREE') : const Text('Go PRO'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     context.read<Manager>().resetUserProgress();
            //   },
            //   child: const Text('Reset User Data'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await context.read<Manager>().signOut();
            //     // Navigator.pop(context);
            //     // context.read<Manager>().addQuestionsToDb(isPro: false);
            //   },
            //   child: const Text('Sign Out'),
            // ),
          ],
        ),
      ),
    );
  }

  // DELETE THIS WIDGET RIGHT AFTER DELETING GO PRO/FREE BUTTON

  Future goProDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Czy na pewno chcesz to zrobić?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: const Text('Nie'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: const Text('Tak'),
          ),
        ],
      ),
    );
  }
}

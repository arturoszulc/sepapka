import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
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
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<Manager>().navigate(Screen.menu),
          ),
          title: const Text('Profil użytkownika'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20.0),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //
              //       // color: Colors.grey,
              //         const SizedBox(width: 48,),
              //         Text(context.read<Manager>().loggedUser!.username,
              //         style: const TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         ),
              //
              //
              //     IconButton(
              //       color: Colors.grey,
              //       iconSize: 20,
              //       onPressed: () {
              //         context.read<Manager>().navigate(Screen.changeUserName);
              //         // Navigator.pushNamed(context, '/settings-change-user-data');
              //       },
              //       icon: const Icon(Icons.edit),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10.0),

              // Container(
              //   height: 3,
              //   width: 150,
              //   color: Colors.grey[300],
              // ),
              // const SizedBox(height: 20.0),
              // const Text('Twoja ranga:'),
              // const SizedBox(height: 20,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       children: [
              //         Text(context.read<Manager>().userRankName),
              //         const SizedBox(height: 10.0),
              //         Text('${context.read<Manager>().loggedUser!.rankTotalPoints} pkt.'),
              //       ],
              //     ),
              //     const SizedBox(width: 20,),
              //     Image.asset(context.read<Manager>().getBadgePath(),
              //       height: 60,
              //       width: 60,),
              //   ],
              // ),

              // const SizedBox(height: 20.0),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: TextFormField(
              //         enabled: false,
              //         // autovalidateMode: AutovalidateMode.onUserInteraction,
              //         initialValue: context.read<Manager>().loggedUser!.username,
              //         // controller: emailFieldController,
              //         textInputAction: TextInputAction.next,
              //         decoration: const InputDecoration(
              //           labelText: 'Nazwa użytkownika',
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         context.read<Manager>().navigate(Screen.changeUserName);
              //         // Navigator.pushNamed(context, '/settings-change-user-data');
              //       },
              //       icon: const Icon(Icons.edit),
              //     ),
              //
              //     const Text('Nazwa użytkownika'),
              //     Container(
              //       margin: EdgeInsets.only(top: 10.0),
              //         padding: const EdgeInsets.all(10.0),
              //         decoration: BoxDecoration(
              //           border: Border.all(),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         child: Text(context.read<Manager>().loggedUser!.username)),
              //   ],
              // ),
              const SizedBox(height: 20.0),


              MenuButton(label: 'Wyloguj się', onPressed: () async {
                await context.read<Manager>().signOut();
                // context.read<Manager>().addQuestionsToDb();
              }),
              // MenuButton(label: 'Usuń postępy użytkownika', onPressed: () {
              //   context.read<Manager>().resetUserProgress();
              // },),
              // MenuButton(label: 'Usuń konto', onPressed: () async {
              //   await context.read<Manager>().signOut();
              //   // context.read<Manager>().addQuestionsToDb(isPro: false);
              // }
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Text('Debug'),
            onPressed: () {
          context.read<Manager>().navigate(Screen.debug);
        }),
      ),
    );
  }


}

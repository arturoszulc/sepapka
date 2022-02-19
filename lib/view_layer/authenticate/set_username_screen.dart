import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';

class SetUsernameScreen extends StatelessWidget {
  SetUsernameScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _setUsernameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ChangeUserData Screen build ***');

    String errorMsg = Provider.of<Manager>(context).errorMsg;
    String username = Provider.of<Manager>(context).loggedUser!.username;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => context.read<Manager>().navigate(Screen.settings),
          // ),
          centerTitle: true,
          title: const Text('Podaj nazwę użytkownika'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Text('Twoja wygenerowana nazwa użytkownika to:'),
              Form(
                key: _setUsernameKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    // initialValue: username,
                    // textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nazwa użytkownika',
                    ),
                    // onTap: () => usernameChanged = true,
                    onChanged: (val) {
                      username = val;
                    },
                    // validator: (val) {
                    //   if (val!.isEmpty || val.length < 3 || val.length > 16) {return 'Nazwa użytkownika musi składać się z 3-16 znaków';}
                    //   return null;
                    // },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 20.0),
                child: Text(
                  errorMsg.isNotEmpty ? errorMsg : '',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await context.read<Manager>().updateUserData(username);
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil('/settings-screen', (Route<dynamic> route) => false);

                },
                child: const Text('Zapisz'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  var result = await context.read<Manager>().navigate(Screen.menu);
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil('/settings-screen', (Route<dynamic> route) => false);

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(fadedButtonColor),
                ),
                child: const Text('Później'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

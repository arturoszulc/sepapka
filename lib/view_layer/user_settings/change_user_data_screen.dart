import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class ChangeUserData extends StatelessWidget {
  const ChangeUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ChangeUserData Screen build ***');

    String errorMsg = Provider.of<Manager>(context).errorMsg;
    String username = Provider.of<Manager>(context).loggedUser!.username;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zmień dane użytkownika'),
      ),
      body: Column(
        children: [
          Form(child:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: username,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nazwa użytkownika',
                border: OutlineInputBorder(),
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
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              errorMsg.isNotEmpty ? errorMsg : '',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(onPressed: () {
            context.read<Manager>().updateUserData(username);
          }, child: const Text('Zapisz'),),
        ],
      ),
    );
  }
}

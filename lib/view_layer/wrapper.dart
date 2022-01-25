import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/view_layer/custom_widgets/app_loading.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'authenticate/authenticate.dart';
import 'menu/menu_main_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Wrapper built ***');


    return Selector<Manager, bool>(
      selector: (_, manager) => manager.loading,
      builder: (_, loading, __) => loading == true ? const Loading() :
          Selector<Manager, LoggedUser?>(
        selector: (_, manager) => manager.loggedUser,
        builder: (_, loggedUser, __) =>
            loggedUser != null ? Menu() : Authenticate(),
      ),
    );

    // final manager = Provider.of<Manager>(context);
    //
    // if (manager.loading == true) {
    //   return const Loading();
    // } else {
    //   if (manager.loggedUser == null) {
    //     return Authenticate();
    //   } else {
    //     return Menu();
    //   }
    // }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/view_layer/custom_widgets/app_loading.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'authenticate/authenticate.dart';
import 'menu_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Wrapper built');

    final manager = Provider.of<Manager>(context);
    if (manager.loading == true) {
      return const Loading();
    }
    if (manager.loggedUser == null) {
      return Authenticate();
    } else {
      return Menu();

    }
  }
}

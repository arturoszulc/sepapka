import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<Manager>(context);

    if (manager.loggedUser == null) {
      debugPrint('loggedUser is null');
      return Authenticate();
    } else {
      debugPrint('loggedUser is NOT null');
      return Center(
          child: Text(
        manager.loggedUser!.documentId,
        style: const TextStyle(color: Colors.white),
      ));
    }
  }
}

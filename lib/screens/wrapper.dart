import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/models/logged_user.dart';
import 'package:sepapka/services/database.dart';

import 'menu_screen.dart';

DatabaseService db = DatabaseService();
Future<LoggedUser?>? tempUser;

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Wrapper built');
    //wrapper sets all of the necessary data
    //1. authetnticate
    // AuthenticateService.user

    final loggedUser = Provider.of<LoggedUser>(context);
    const String uid = '123';

    return FutureBuilder(
        future: tempUser = db.getUserData(uid),
        builder: (context, AsyncSnapshot<LoggedUser> snapshot) {
          if (snapshot.hasData) {
            debugPrint('OK: ${snapshot.data!.documentId}');
            return Menu();
          } else
            debugPrint('NOT OK');
          return Container();
        }
    );
  }

  Future<LoggedUser> prepareUserData(LoggedUser loggedUser, String uid) async {
    debugPrint('prepareUserData function deployed');


    //2. fetch user from DB
    //var LoggedUser = DatabaseService.getUserData
    loggedUser = await db.getUserData(uid);

    debugPrint('LOGGED USER DOWNLOADED');
    debugPrint('LOGGED USER ID: ${loggedUser.documentId}');
    debugPrint('LOGGED USER qKnown: ${loggedUser.qKnown}');

    ///3. Sprawdź czy lista pytań jest aktualna
    ///a) wyciągnij numer listy pytań z Usera USERSERVICE
    ///
    ///b) wyciągnij numer listy pytań z bazy DATABASESERVICE
    ///c) porównaj i w razie auktualnij USERSERVICE
    ///c.1) Jeśli wersja nieaktualna, to pobierz liste pytań DATABASESERViCE
    ///c.1) uaktualnij Usera USERSERVICE
    ///
    ///
    //get user data and create LoggedUser object


    //fill loggedUser object

    return loggedUser;
  }
}
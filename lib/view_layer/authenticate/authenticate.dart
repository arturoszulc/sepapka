import 'package:flutter/material.dart';
import 'package:sepapka/view_layer/authenticate/sing_in_screen.dart';



class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);



  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  bool showRegister = false; //nie ma jeszcze ekranu Register, więc trzeba by go stworzyć w razie potrzeby

  @override
  Widget build(BuildContext context) {

    // brak ekranu register, więc zwraca tylko jedną możliwość. W razie czego zrobić tu funkcję if{} else{}
    return SignInScreen();

  }
}
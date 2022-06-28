import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/colors.dart';

class PurchaseLoading extends StatelessWidget {
  const PurchaseLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
        CircularProgressIndicator(
          color: proColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          // child: Text('Wczytywanie danych...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ),
      ]
      ),
    );
  }
}

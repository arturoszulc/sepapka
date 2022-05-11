import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/colors.dart';
import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';

class PurchasePending extends StatelessWidget {
  const PurchasePending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(Screen.menu),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.read<Manager>().navigate(Screen.menu),
            ),
            // title: const Text('Purchase Error'),
            // centerTitle: true,
          ),
          body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              SpinKitFadingCircle(
                color: myPrimary,
                size: 50.0,
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Twoja transakcja jest przetwarzana\nMoże to zająć kilka minut.', textAlign: TextAlign.center,),
              ),
            ],),),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   icon: const Icon(Icons.exit_to_app),
          //   onPressed: () {
          //     context.read<Manager>().navigate(Screen.menu);
          //   }, label: const Text('Powrót do menu'),),

        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';

class PurchaseScreen extends StatelessWidget {
  PurchaseScreen({Key? key}) : super(key: key);


  final TextStyle featuresTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Purchase Screen built');
    final manager = Provider.of<Manager>(context);
    return WillPopScope(
      onWillPop: () {
        context.read<Manager>().closeStore();
        return context.read<Manager>().navigate(Screen.chooseLevel);
      },
      child: Scaffold(
        backgroundColor: myPrimaryLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.read<Manager>().closeStore();
              context.read<Manager>().navigate(Screen.chooseLevel);
            },
          ),
          // title: const Text('Odblokuj pytania'),
          // centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(flex: 1,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset('assets/images/general/sepapka_pro.png')),
              ),
              Expanded( flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.question_mark_rounded),
                          title: Text('odblokuj wszystkie pytania', style: featuresTextStyle,),

                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          const Icon(Icons.settings),
                          Text('uzyskaj dostęp do wszystkich funkcji', style: featuresTextStyle,),
                        ],),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            manager.buyProduct();
          },
          label: Text('Kup za ${manager.productPrice} zł'),
          backgroundColor: myComplementary,
        ),
      ),
    );
  }
}

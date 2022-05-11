import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  static const TextStyle featuresTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const double iconSize = 45.0;
  static const Color iconColor = myComplementary;
  static const EdgeInsetsGeometry tilePadding = EdgeInsets.symmetric(horizontal: 40, vertical: 10);

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
        // backgroundColor: myPrimaryLight,
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
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset('assets/images/general/sepapka_pro.png')),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      ListTile(
                        contentPadding: tilePadding,
                        leading: Icon(
                          Icons.question_mark_rounded,
                          size: iconSize,
                          color: iconColor,
                        ),
                        title: Text(
                          'odblokuj wszystkie pytania',
                          style: featuresTextStyle,
                        ),
                      ),
                      ListTile(
                        contentPadding: tilePadding,
                        leading: Icon(
                          Icons.settings,
                          size: iconSize,
                          color: iconColor,
                        ),
                        title: Text(
                          'uzyskaj dostęp do nadchodzących funkcji',
                          style: featuresTextStyle,
                        ),
                      ),
                      ListTile(
                        contentPadding: tilePadding,
                        leading: Icon(
                          Icons.rocket_launch,
                          size: iconSize,
                          color: iconColor,
                        ),
                        title: Text(
                          'wspieraj dalszy rozwój aplikacji',
                          style: featuresTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: myComplementary,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Text(
                            'Kup za ${manager.productPrice} zł',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                              manager.buyProduct();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'licencja dożywotnia',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     manager.buyProduct();
        //   },
        //   label: Text('Kup za ${manager.productPrice} zł'),
        //   backgroundColor: myComplementary,
        // ),
      ),
    );
  }
}

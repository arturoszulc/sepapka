import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/custom_widgets/build_question_image.dart';

import '../../viewmodel_layer/manager.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  static const TextStyle featuresTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const double iconSize = 45.0;
  static const Color iconColor = proColor;
  static const EdgeInsetsGeometry tilePadding = EdgeInsets.symmetric(horizontal: 40, vertical: 10);


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String logoName = isDarkMode ? 'sepapka_pro_dark.png' : 'sepapka_pro.png';
    debugPrint('*** Purchase Screen built');
    final manager = Provider.of<Manager>(context);
    return WillPopScope(
      onWillPop: () {
        // context.read<Manager>().closeStore();
        return context.read<Manager>().navigate(Screen.menu);
      },
      child: Scaffold(
        // backgroundColor: myPrimaryLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // context.read<Manager>().closeStore();
              context.read<Manager>().navigate(Screen.menu);
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
                    // child: buildImage(context, 'assets/images/general/$logoName')),
                    child: Image.asset('assets/images/general/$logoName')),
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
                          Icons.calculate,
                          size: iconSize,
                          color: iconColor,
                        ),
                        title: Text(
                          'odblokuj kalkulatory i tablice',
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
                        backgroundColor: proColor,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Text('Kup za ${manager.product?.priceString}',
                            // 'Kup za ${manager.productPrice} zł',
                            // style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                              manager.buyProduct();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
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

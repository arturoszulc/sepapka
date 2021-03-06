import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/controllers/purchase_Controller.dart';


class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  static const TextStyle featuresTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const double iconSize = 45.0;
  static const Color iconColor = proColor;
  static const EdgeInsetsGeometry tilePadding = EdgeInsets.symmetric(horizontal: 40, vertical: 10);


  @override
  Widget build(BuildContext context) {
    debugPrint('*** Purchase Screen built');

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String logoName = isDarkMode ? 'sepapka_pro_dark.png' : 'sepapka_pro.png';
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                        Icons.school,
                        size: iconSize,
                        color: iconColor,
                      ),
                      title: Text(
                        'uzyskaj dost??p do wszystkich lekcji Akademii',
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
                        'wspieraj dalszy rozw??j aplikacji',
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
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) => FloatingActionButton.extended(
                        backgroundColor: proColor,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Text('Kup za ${ref.read(purchaseController).product?.priceString}',
                            // 'Kup za ${manager.productPrice} z??',
                            // style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                              ref.read(purchaseController.notifier).buyProduct();
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'licencja do??ywotnia',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     manager.buyProduct();
      //   },
      //   label: Text('Kup za ${manager.productPrice} z??'),
      //   backgroundColor: myComplementary,
      // ),

  }
}

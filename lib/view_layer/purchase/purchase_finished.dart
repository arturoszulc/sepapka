import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/consts/colors.dart';

class PurchaseFinished extends StatelessWidget {
  const PurchaseFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String logoName = isDarkMode ? 'sepapka_pro_dark.png' : 'sepapka_pro.png';
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                // child: buildImage(context, 'assets/images/general/$logoName')),
                child: Image.asset('assets/images/general/$logoName')),
            const SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                const Icon(
                  Icons.receipt_long,
                  size: 60,
                  color: proColor,
                ),
                Text('Dzięki za zakup!', style: Theme.of(context).textTheme.headline4),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
            // child: buildImage(context, 'assets/images/general/sepapka_pro.png')),

          // child: Image.asset('assets/images/general/sepapka_pro.png')
              ),
            // Icon(Icons.check_box, size: 36, color: Colors.green,),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Transakcja została potwierdzona. Wszystkie funkcje odblokowane.', style: TextStyle(color: proColor, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 10,),
             Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Twoje wsparcie umożliwi mi dalszy rozwój aplikacji. Pamiętaj o jej aktualizowaniu, by niczego nie przegapić!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
            ),
            const SizedBox(height: 50,),

            Expanded(
              child: Column(
                children: [
                  Text('Masz pomysł na ciekawą funkcje? Daj znać na:',textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(height: 10,),
                  Text('kontakt@teoriaelektryki.pl', style: Theme.of(context).textTheme.headline6,),
                ],
              ),
            ),
    Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
            backgroundColor: proColor,
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.pop();
            }, label: const Text('Powrót'),),
      ),
    ),
          ],),
      );
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Consumer(
      //   builder: (BuildContext context, WidgetRef ref, Widget? child) => FloatingActionButton.extended(
      //     backgroundColor: proColor,
      //     icon: const Icon(Icons.exit_to_app),
      //     onPressed: () {
      //       context.goNamed(MyScreen.menu.name);
      //     }, label: const Text('Powrót do menu'),),
      // ),


  }
}

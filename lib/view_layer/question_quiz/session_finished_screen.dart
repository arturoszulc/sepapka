import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SessionFinished extends StatelessWidget {
  const SessionFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** SessionFinished screen built ***');
    String userScore = context.read<Manager>().userScore;
    return WillPopScope(
      onWillPop: () async {
        await context.read<Manager>().navigate(Screen.menu);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sesja zakończona!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                ),
                const SizedBox(height: 30.0),
                const SizedBox(height: 30.0),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 1000,
                  percent: double.parse(userScore) / 100,
                  center: Text(
                    '$userScore %',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  header: const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Twój wynik",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                // Text('${context.read<Manager>().userScore} %',
                //     style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                // const SizedBox(height: 30.0),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     // context.read<Manager>().resetIsUserPromotedFLag();
                //     context.read<Manager>().navigate(Screen.menu);
                //   },
                //   icon: const Icon(Icons.exit_to_app),
                //   label: const Text('Wyjście'),
                // ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
            context.read<Manager>().navigate(Screen.menu);
          }, label: const Text('Powrót do menu'),),
        ),
      ),
    );
  }
}

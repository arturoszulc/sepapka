import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SessionFinished extends StatelessWidget {
  const SessionFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** SessionFinished screen built ***');
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sesja zakończona!',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 30.0),
              const SizedBox(height: 30.0),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) => CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: double.parse(ref.read(manager).userScore) / 100,
                  center: Text(
                      '${ref.read(manager).userScore} %',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),

                  header: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Twój wynik",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Theme.of(context).colorScheme.primary,

        ),
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
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) => FloatingActionButton.extended(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
            ref.read(manager).navigate(MyScreen.menu);
          }, label: const Text('Powrót do menu'),),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

Widget buildProgressBar(BuildContext context) {

  String progress = context.read<Manager>().progressPercentGlobal;
  debugPrint('Progress: $progress');
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 15.0, right: 15.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      // color: Colors.grey,
      children: [
        Text('Poziom: ${context.read<Manager>().userRankName}', style: const TextStyle(fontWeight: FontWeight.bold)),
        Padding(
        padding: const EdgeInsets.all(15.0),
        child: LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2000,
          percent: double.parse(progress)/100,
          center: Text('$progress %'),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.green,
        ),
      ),]
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

Widget buildProgressBar(BuildContext context) {
  return Column(
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
        percent: context.read<Manager>().progressPercentGlobal,
        center: Text('${(context.read<Manager>().progressPercentGlobal*100).toString()} %'),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.green,
      ),
    ),]
  );
}

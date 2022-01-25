import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

Widget buildProgressBar(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    // color: Colors.grey,
    children: [
      const Text('Progress bar', style: TextStyle(fontWeight: FontWeight.bold)),
      Padding(
      padding: const EdgeInsets.all(15.0),
      child: LinearPercentIndicator(
        alignment: MainAxisAlignment.center,
        width: MediaQuery.of(context).size.width - 80,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        percent: context.read<Manager>().progressPercent,
        center: Text('${(context.read<Manager>().progressPercent*100).toString()} %'),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.green,
      ),
    ),]
  );
}

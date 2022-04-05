import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

Widget buildProgressBar(BuildContext context, double? width) {

  String progress = context.read<Manager>().progressPercentGlobal;
  // String badgePath = context.read<Manager>().getBadgePath();
  // debugPrint('Progress: $progress');
  return LinearPercentIndicator(
    alignment: MainAxisAlignment.center,
    animation: true,
    animateFromLastPercent: true,
    lineHeight: 10.0,
    width: width,
    animationDuration: 2000,
    percent: double.parse(progress)/100,
    // center: Text('$progress %'),
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: Colors.green,
  );

  //wersja z poziomem nad barem i odznaką obok
  // return Padding(
  //   padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 15.0, right: 15.0),
  //   child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       // color: Colors.grey,
  //       children: [
  //         // Text('Poziom: ${context.read<Manager>().userRankName}', style: const TextStyle(fontWeight: FontWeight.bold)),
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 flex: 1,
  //                 child: Image.asset(badgePath,
  //                   height: 40,
  //                   width: 40,),
  //               ),
  //               const SizedBox(width: 10),
  //               Expanded(
  //                 flex: 9,
  //                 child: LinearPercentIndicator(
  //                   alignment: MainAxisAlignment.center,
  //                   animation: true,
  //                   lineHeight: 20.0,
  //                   animationDuration: 2000,
  //                   percent: double.parse(progress)/100,
  //                   center: Text('$progress %'),
  //                   linearStrokeCap: LinearStrokeCap.roundAll,
  //                   progressColor: Colors.green,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),]
  //   ),
  // );
}

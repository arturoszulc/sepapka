import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/consts/nav.dart';
import '../../../utils/tabels/obciazalnosc_przewodow.dart';
import '../../../viewmodel_layer/manager.dart';

class WireAmpacity extends StatelessWidget {
  const WireAmpacity({Key? key}) : super(key: key);

  final Divider divider = const Divider(height: 20, thickness: 2, color: Colors.grey,);


  @override
  Widget build(BuildContext context) {

    String key = 'A1';
    return WillPopScope(
      onWillPop: () {
        // context.read<Manager>().closeStore();
        return context.read<Manager>().navigate(Screen.menu);
      },
      child: Scaffold(
        // backgroundColor: myPrimaryLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.read<Manager>().navigate(Screen.menu);
            },
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
                // fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                      flex: 1,
                      child: Container(color: Colors.red, child: Text('Przekrój przewodów [mm\u00B2]', textAlign: TextAlign.center,))),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Expanded(child: Text('Liczba obciążonych przewodów', textAlign: TextAlign.center,)),
                            ],
                          ),
                          Row(
                            children: const [
                              Expanded(child: Text('2', textAlign: TextAlign.center,)),
                              Expanded(child: Text('3', textAlign: TextAlign.center,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
                )
                // Row(
                //   children: const [
                //     Expanded(
                //       child: Text('Przekrój przewodu [mm]', textAlign: TextAlign.center,),
                //     ),
                //     Expanded(
                //       child: Text('2', textAlign: TextAlign.center,),
                //     ),
                //     Expanded(
                //       child: Text('3', textAlign: TextAlign.center,),
                //     ),
                //   ],
                //
                // ),
                ),
            divider,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                        children: tableWireAmpacity[key]!
                            .twoWires
                            .keys
                            .map((e) => Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                ))
                            .toList()),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: tableWireAmpacity[key]!
                          .twoWires
                          .values
                          .map((e) => Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: tableWireAmpacity[key]!
                          .threeWires
                          .values
                          .map((e) => Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

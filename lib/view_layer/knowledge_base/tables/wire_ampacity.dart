import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/tabels/table_wire_ampacity.dart';

import '../../../utils/consts/nav.dart';
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

            DataTable(
                columns: const [
                  DataColumn(label: Text('Przekrój przewodów [mm\u00B2]')),
                  DataColumn(label: Text('Dwa obciążone przewody')),
                  DataColumn(label: Text('Trzy obciążone przewody')),
                ],
                rows: getRows(tableWireAmpacityData[key]!))


            // IntrinsicHeight(
            //     // fit: FlexFit.tight,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 8.0),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //       Expanded(
            //           flex: 1,
            //           child: Container(color: Colors.red, child: Text('Przekrój przewodów [mm\u00B2]', textAlign: TextAlign.center,))),
            //       Expanded(
            //         flex: 2,
            //         child: Container(
            //           color: Colors.green,
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: const [
            //                   Expanded(child: Text('Liczba obciążonych przewodów', textAlign: TextAlign.center,)),
            //                 ],
            //               ),
            //               Row(
            //                 children: const [
            //                   Expanded(child: Text('2', textAlign: TextAlign.center,)),
            //                   Expanded(child: Text('3', textAlign: TextAlign.center,)),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //   ],
            // ),
            //     )
            //     ),
            // divider,
            // Expanded(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: ListView(
            //             children: tableWireAmpacityData[key]!
            //                 .twoWires
            //                 .keys
            //                 .map((e) => Text(
            //                       e.toString(),
            //                       textAlign: TextAlign.center,
            //                     ))
            //                 .toList()),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: ListView(
            //           children: tableWireAmpacityData[key]!
            //               .twoWires
            //               .values
            //               .map((e) => Text(
            //                     e.toString(),
            //                     textAlign: TextAlign.center,
            //                   ))
            //               .toList(),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: ListView(
            //           children: tableWireAmpacityData[key]!
            //               .threeWires
            //               .values
            //               .map((e) => Text(
            //                     e.toString(),
            //                     textAlign: TextAlign.center,
            //                   ))
            //               .toList(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}

List<DataRow> getRows(WireNumber wireNumber)
    {
      List<String> keyList = wireNumber.twoWires.keys.toList();
      List<String> value2List = wireNumber.twoWires.values.toList();
      List<String> value3List = wireNumber.threeWires.values.toList();
      for (String key in keyList) {
        final cells = [key, wireNumber.twoWires[key], wireNumber.threeWires[key]];
        return DataRow(cells: getCells(cells));
      }
  // final cells = [wireNumber.twoWires.keys, wireNumber.twoWires.values, wireNumber.threeWires.values];
  // return DataRow(cells: getCells(cells));
}

List<DataCell> getCells(List<dynamic> cells) => cells
    .map((data) => DataCell(data is Color
    ? Container(
  width: 25,
  height: 15,
  color: data,
)
    : Text('$data')))
    .toList();
}

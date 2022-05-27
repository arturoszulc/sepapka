import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/tabels/table_wire_symbols.dart';

import '../../../utils/consts/nav.dart';
import '../../../viewmodel_layer/manager.dart';

class WireSymbols extends StatelessWidget {
  const WireSymbols({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** WireSymbols built ***');
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return context.read<Manager>().navigate(Screen.knowledgeBase);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.read<Manager>().navigate(Screen.knowledgeBase);
              },
            ),
            title: const Text('Oznaczenia przewodów'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: 'polskie'),
              Tab(text: 'zharmonizowane'),
            ]),
          ),
          body: TabBarView(children: [
            buildPolishSymbolsTable(context),
            buildHarmonizedSymbolsTable(context),
            // buildRankTop(context),
            // buildRankUser(context),
          ]),
        ),
      ),
    );
  }

  Widget buildPolishSymbolsTable(BuildContext context) {
    debugPrint('*** buildPolishSymbolsTable rebuilt ***');
    return SingleChildScrollView();
  }

  Widget buildHarmonizedSymbolsTable(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.5;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children:
          // for (String key in wireSymbolsHarmonized.keys) buildWireSymbolTable()
      wireSymbolsHarmonized.entries.map<Widget>((data) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.key, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              getTable(width, data.value),
            ],
          ),
        ),
      )).toList(),

        // Text(wireSymbolsHarmonized.keys.single[0]),
        // FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: DataTable(
        //       columns: const [],
        //         rows:  [
        //           DataRow(cells: [
        //             DataCell(Text('haha')),
        //           ]),
        //         ])),

      ),
    );
  }

  List<Widget> buildWireSymbolTable(double width, Map<String, List<WireSymbolHarmonized>> map) {
    return map.entries.map<Widget>((data) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(data.key),
          FittedBox(child: getTable(width, data.value)),
        ],
      ),
    )).toList();

    // return Column(
    //   children: [
    //     DataTable(columns: [], rows: []),
    //   ],
    // );
  }

  DataTable getTable(double width, List<WireSymbolHarmonized> symbolList) {
    return DataTable(
      horizontalMargin: 0,
      columnSpacing: 0,
      headingRowHeight: 0,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text(''))
      ],
      rows: symbolList.map<DataRow>((e) => (DataRow(cells: [
      DataCell(Container(
          // color: Colors.red,
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(e.description,),
          ))),
      DataCell(Container(
          // width: width,
          // color: Colors.green,
          child: Text(e.symbol, textAlign: TextAlign.center)))
    ]
      )),
      ).toList(),
    );
  }

//
// List<Widget> buildWireSymbolTables(Map<String, List<WireSymbolHarmonized>> map) {
//   for (var i = 0; i < 5; i++) {
//     return Column();
//   }
//
//   return [Column()];
// }
// if (map.isEmpty) return [Container()];
//   for (String key in map.keys) {
//     return Column();
//     debugPrint(key);
//     for (WireSymbolHarmonized item in map[key]!) {
//       debugPrint('[${item.description}, ${item.symbol}]');
//     }
//   }


//   List<DataRow> getRows(List<WireSymbolHarmonized> wireSymbols) {
//     List<DataRow> rows = [];
//     for (String key in wireNumber.twoWires.keys) {
//       final cells = [key, wireNumber.twoWires[key], wireNumber.threeWires[key]];
//       rows.add(DataRow(cells: getCells(cells)));
//     }
//     return rows;
//
//     // final cells = [wireNumber.twoWires.keys, wireNumber.twoWires.values, wireNumber.threeWires.values];
//     // return DataRow(cells: getCells(cells));
//   }
//
//   List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(Text('$data'))).toList();
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/build_question_image.dart';
import 'package:sepapka/utils/tabels/table_wire_ampacity.dart';

import '../../../utils/consts/nav.dart';
import '../../../viewmodel_layer/manager.dart';

class WireAmpacity extends StatefulWidget {
  WireAmpacity({Key? key}) : super(key: key);

  @override
  State<WireAmpacity> createState() => _WireAmpacityState();
}

class _WireAmpacityState extends State<WireAmpacity> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    String key = layingWiresMethods[index].symbol;
    return WillPopScope(
      onWillPop: () {
        return context.read<Manager>().navigate(Screen.knowledgeBase);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<Manager>().navigate(Screen.knowledgeBase);
            },
          ),
          title: const Text('Obciążalność przewodów'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: (index == 0) ? null : () {
                                setState(() {
                                  if (index > 0) index -= 1;
                                });
                              },
                              icon: const Icon(Icons.navigate_before_outlined, size: 48,)),
                          Text(
                            layingWiresMethods[index].symbol,
                            textAlign: TextAlign.center,
                            textScaleFactor: 2,
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                              onPressed:
                          (index == layingWiresMethods.length-1) ? null : () {
                            setState(() {
                            if (index < layingWiresMethods.length-1) index += 1;
                            });
                          }, icon: const Icon(Icons.navigate_next_outlined, size: 48,)),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: buildImage(context,
                              layingWiresMethods[index].assetPath,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(layingWiresMethods[index].description),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                  headingRowHeight: 70,
                    // columnSpacing: 15.0,
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Przekrój żył\n[mm\u00B2]')),
                      DataColumn(label: Text('Obciążalność\nobwodu 1-f [A]')),
                      DataColumn(label: Text('Obciążalność\nobwodu 3-f [A]')),
                    ],
                    rows: getRows(tableWireAmpacityData[key]!)),
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Szczegóły:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Dane dotyczą przewodów miedzianych w izolacji/płaszczu PVC. Temperatura żyły: 70\u00B0C. Temperatura otoczenia: 25\u00B0C'),
              ),


            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(WireNumber wireNumber) {
    List<DataRow> rows = [];
    for (String key in wireNumber.twoWires.keys) {
      final cells = [key, wireNumber.twoWires[key], wireNumber.threeWires[key]];
      rows.add(DataRow(cells: getCells(cells)));
    }
    return rows;

    // final cells = [wireNumber.twoWires.keys, wireNumber.twoWires.values, wireNumber.threeWires.values];
    // return DataRow(cells: getCells(cells));
  }

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(Text('$data'))).toList();
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/tabels/oznaczenia_przewodow_barwami.dart';

import '../../../viewmodel_layer/manager.dart';

class WireColors extends StatelessWidget {
  const WireColors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columns = TableWireColors().headers;
    final rows = TableWireColors().rows;

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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FittedBox(
              // fit: BoxFit.fitWidth,
              child: DataTable(columns: getColumns(columns), rows: getRows(rows))),
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}

List<DataRow> getRows(List<Przewod> rows) => rows.map((Przewod przewod) {
      final cells = [przewod.namePL, przewod.nameENG, przewod.colorCode, przewod.color];
      return DataRow(cells: getCells(cells));
    }).toList();

List<DataCell> getCells(List<dynamic> cells) => cells
    .map((data) => DataCell(data is Color
        ? Container(
            width: 25,
            height: 15,
            color: data,
          )
        : Text('$data')))
    .toList();

// List<DataCell> getCells2(List<dynamic> cells) => cells.map((data) {
//       switch (data) {
//         case Color:
//           return DataCell(Container());
//         case String:
//           return DataCell(Text(data),);
//         default:
//           return DataCell(Container());
//       }
//     }).toList();

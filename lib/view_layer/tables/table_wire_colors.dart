import 'package:flutter/material.dart';

import '../../../utils/tables_data/table_wire_colors_data.dart';

class TableWireColors extends StatelessWidget {
  const TableWireColors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: myPrimaryLight,
      appBar: AppBar(
        title: const Text('Barwy przewodów'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: DataTable(
                columnSpacing: 25,
                columns: getColumns(tableWireColorDataHeaders), rows: getRows(tableWireColorDataRows))),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}

List<DataRow> getRows(List<Wire> rows) =>
    rows.map((Wire wire) {
      final cells = [wire.namePL, wire.nameENG, wire.colorCode, wire.color];
      return DataRow(cells: getCells(cells));
    }).toList();

List<DataCell> getCells(List<dynamic> cells) =>
    cells
        .map((data) {
      if (data == Colors.greenAccent) {
        return DataCell(Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 25,
              height: 7.5,
              color: Colors.yellow,
              ),
            Container(
              width: 25,
              height: 7.5,
              color: Colors.green,
            ),
          ],
        ));
      }
      if (data is Color) {
        return DataCell(Container(
          width: 25,
          height: 15,
          color: data,
        ));
      }
      return DataCell(Text('$data'));
    }
    )
        .toList();

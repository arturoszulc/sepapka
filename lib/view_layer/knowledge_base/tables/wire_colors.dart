import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/my_screens.dart';

import '../../../utils/tabels/table_wire_colors.dart';
import '../../../viewmodel_layer/manager.dart';

class WireColors extends StatelessWidget {
  const WireColors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columns = TableWireColors().headers;
    final rows = TableWireColors().rows;

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
                columns: getColumns(columns), rows: getRows(rows))),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}

List<DataRow> getRows(List<Wire> rows) =>
    rows.map((Wire przewod) {
      final cells = [przewod.namePL, przewod.nameENG, przewod.colorCode, przewod.color];
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
// DataCell(
//     // data is Color
//     //     ? Container(
//     //         width: 25,
//     //         height: 15,
//     //         color: data,
//     //       )
//         : Text('$data')
// )
    )
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

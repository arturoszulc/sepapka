import 'package:flutter/material.dart';
import 'package:sepapka/utils/tables_data/table_wire_diameter.dart';


class TableWireDiameter extends StatelessWidget {
  const TableWireDiameter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: myPrimaryLight,
      appBar: AppBar(
        title: const Text('Przekroje i średnice'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                    columnSpacing: 25,
                    columns: getColumns(tableWireDiameterHeaders), rows: getRows(tableWireDiameterRows)
                ),
            ),
            const SizedBox(height: 20,),
            details(),
          ],
        ),
      ),
    );
  }

  Widget details() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: const [
        Text('Wartości przekrojów i średnic pochodzą z normy DIN VDE 0295.'),
        SizedBox(height: 10,),
        Text('Podane średnice są średnicami maksymalnymi dla przewodów miedzianych wielodrutowych (klasa 2).'),
        SizedBox(height: 10,),
        Text('Podane odpowiedniki normy amerykańskiej AWG są jedynie przybliżonymi ekwiwalentami pod względem obciążalności długotrwałej. Dane pochodzą z dokumentu ,,Budowa żyły według DIN VDE 0295, IEC 60228 i HD 383", dostępnego na stronie producenta Helukabel.')

      ],
    ),
  );

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();
}

List<DataRow> getRows(List<WireDiameter> rows) =>
    rows.map((WireDiameter wire) {
      final cells = [wire.mm2, wire.diameter, wire.awg];
      return DataRow(cells: getCells(cells));
    }).toList();

List<DataCell> getCells(List<dynamic> cells) =>
    cells
        .map((data) => DataCell(Text('$data')),
    ).toList();

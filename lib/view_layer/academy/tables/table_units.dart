import 'package:flutter/material.dart';
import 'package:sepapka/utils/tables_data/table_units_data.dart';

import '../../../utils/consts/my_screens.dart';
import '../../../viewmodel_layer/manager.dart';


class TableUnits extends StatefulWidget {
  const TableUnits({Key? key}) : super(key: key);

  @override
  State<TableUnits> createState() => _TableUnitsState();
}

class _TableUnitsState extends State<TableUnits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jednostki i wielkości'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: unitGroups.map((unitGroup) => ExpansionPanelRadio(
                value: unitGroup.name,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => buildHeader(unitGroup),
                body: Column(
                  children: <Widget>[
                    ...unitGroup.tiles.map(buildUnitTile).toList()],
                ),
            ))
                .toList(),

        ),
      ),
    );
  }

  buildHeader(UnitGroup unitGroup) => ListTile(
    title: Text(unitGroup.name),
  );

  buildUnitTile(UnitTile unitTile) => Card(
    child: Row(children: [
      Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        Text(unitTile.symbol, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
        Text(unitTile.unit, textAlign: TextAlign.center,),
      ],),
          )),
      Expanded(
          flex: 3,
          child: Text(unitTile.name, style: TextStyle(fontSize: 18),)),
    ],),
    // visualDensity: VisualDensity(vertical: 3),
    // minLeadingWidth: 100,
    // horizontalTitleGap: 22,
    // leading:
    //   Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text(unitTile.symbol, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26), textAlign: TextAlign.center,),
    //       Text(unitTile.unit, textAlign: TextAlign.center,),
    //       ]),
    //
    // title: Text(unitTile.name),
    // subtitle: Text(unitTile.unit),
  );

}

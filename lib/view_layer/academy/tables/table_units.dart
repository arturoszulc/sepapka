import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/tables_data/table_units_data.dart';
import 'package:sepapka/viewmodel_layer/table_controller.dart';

class TableUnits extends ConsumerWidget {
  TableUnits({Key? key}) : super(key: key);

  final TextEditingController searchInput = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Jednostki i wielkości'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchInput,
              decoration: InputDecoration(
                  label: const Text('Szukaj'),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: ref.watch(unitSearch).isEmpty
                        ? null
                        : () {
                            searchInput.clear();
                            ref.read(tableController).search('');
                          },
                    icon: const Icon(Icons.clear),
                  )),
              onChanged: (val) {
                log('changed val');
                ref.read(tableController).search(val);
              },
            ),
          ),
          ref.watch(unitSearch).isEmpty ? const TableUnitsGrouped() : const TableUnitsSearched(),
        ],
      ),
    );
  }
}

class TableUnitsGrouped extends StatelessWidget {
  const TableUnitsGrouped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        children: unitGroups
            .map((unitGroup) => ExpansionPanelRadio(
                  value: unitGroup.name,
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpanded) => buildGroupHeader(unitGroup),
                  body: Column(
                    children: <Widget>[...unitGroup.tiles.map(buildUnitTile).toList()],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class TableUnitsSearched extends ConsumerWidget {
  const TableUnitsSearched({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UnitTile> searchedList = ref.watch(unitSearchedList);
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[...searchedList.map(buildUnitTile)],
      ),
    );
  }
}

// Widget tableUnitsSearched(List<UnitTile> list) {
//   return Text('searching...');
// }

Widget buildGroupHeader(UnitGroup unitGroup) => ListTile(
      title: Text(unitGroup.name),
    );

Widget buildUnitTile(UnitTile unitTile) => Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unitTile.symbol,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unitTile.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(unitTile.unit, style: const TextStyle(fontSize: 12)),
                  ],
                )),
          ],
        ),
      ),
    );

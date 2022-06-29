
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/tables_data/table_units_data.dart';
import 'package:sepapka/controllers/table_controller.dart';

class TableUnits extends ConsumerWidget {
  TableUnits({Key? key}) : super(key: key);

  final TextEditingController searchInput = TextEditingController();

  void unFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Jednostki i wielkości'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          debugPrint('gesture detector tapped');
          unFocus(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
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
                                unFocus(context);
                                ref.read(tableController).searchUnitTable('');
                              },
                        icon: const Icon(Icons.clear),
                      )),
                  onChanged: (val) {
                    ref.read(tableController).searchUnitTable(val);
                  },
                ),
              ),
            ),
            Expanded(
                flex: 7,
                child: ref.watch(unitSearch).isEmpty ? const TableUnitsGrouped() : const TableUnitsSearched()),
          ],
        ),
      ),
    );
  }
}

class TableUnitsGrouped extends StatelessWidget {
  const TableUnitsGrouped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ExpansionPanelList.radio(
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
      ),]
    );
  }
}

class TableUnitsSearched extends ConsumerWidget {
  const TableUnitsSearched({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UnitTile> searchedList = ref.watch(unitSearchedList);
    return ListView(
      children: <Widget>[...searchedList.map(buildUnitTile)],
    );
  }
}

Widget buildGroupHeader(UnitGroup unitGroup) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child:   ListTile(
        title: Text(unitGroup.name,
          style: const TextStyle(fontSize: 18),
        ),
      ),
);

Widget buildUnitTile(UnitTile unitTile) => Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unitTile.symbol,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unitTile.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(unitTile.unit, style: const TextStyle(fontSize: 12)),
                  ],
                )),
          ],
        ),
      ),
    );



import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/tables_data/table_units_data.dart';

final unitSearch = StateProvider.autoDispose<String>((ref) => '');

final unitSearchedList = Provider.autoDispose<List<UnitTile>>((ref) {
  final String searchValue = ref.watch(unitSearch);
  if (searchValue.isEmpty) return [];
  List<UnitTile> unitTileList = [];

  for (final unitGroup in unitGroups) {
    for (final tile in unitGroup.tiles) {
      if (tile.name.contains(searchValue)) unitTileList.add(tile);
          }
  }
  return unitTileList;

});

final tableController = Provider.autoDispose<TableController>((ref) => TableController(ref));


class TableController {
  final Ref _ref;

  TableController(this._ref) {
    log('^^^ Table Controller initialized ^^^');
  }

  void searchUnitTable(String val) {
    log('TableController, sending: $val');
    _ref.read(unitSearch.notifier).state = val.toLowerCase();
  }
}
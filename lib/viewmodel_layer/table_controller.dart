

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/tables_data/table_units_data.dart';

final unitSearch = StateProvider<String>((ref) => '');

final unitSearchedList = Provider<List<UnitTile>>((ref) {
  log('unitSeachedList recalculated');
  final String searchValue = ref.watch(unitSearch);
  if (searchValue.isEmpty) return [];
  List<UnitTile> unitTileList = [];

  for (final unitGroup in unitGroups) {
    for (final tile in unitGroup.tiles) {
      if (tile.name.contains(searchValue)) unitTileList.add(tile);
          }
  }

  log(unitTileList.toString());
  return unitTileList;

});

final tableController = Provider<TableController>((ref) => TableController(ref));


class TableController {
  final Ref _ref;

  TableController(this._ref) {
    log('^^^ Table Controller initialized ^^^');
  }

  void search(String val) {
    log('TableController, sending: $val');
    _ref.read(unitSearch.notifier).state = val.toLowerCase();
  }
}
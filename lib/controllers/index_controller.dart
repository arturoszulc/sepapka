


import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/models/academy/index_entry_model.dart';

import '../utils/lessons_data/index_data.dart';

final indexSearch = StateProvider.autoDispose<String>((ref) => '');

final indexSearchedList = Provider.autoDispose<List<IndexEntry>>((ref) {
  log('Index searched list recalculated');
  final String searchValue = ref.watch(indexSearch);
  if (searchValue.isEmpty) return indexList;
  List<IndexEntry> filteredList = [];

  for (final entry in indexList) {
      if (entry.title.contains(searchValue)) filteredList.add(entry);

  }
  return filteredList;
});


final indexController = Provider.autoDispose<IndexController>((ref) => IndexController(ref));


class IndexController {
  final Ref _ref;

  IndexController(this._ref) {
    log('^^^ Table Controller initialized ^^^');
  }

  void searchIndex(String val) {
    log('TableController, sending: $val');
    _ref.read(indexSearch.notifier).state = val.toLowerCase();
  }

}
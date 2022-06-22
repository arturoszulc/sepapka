import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/question_list.dart';

import '../model_layer/models/question.dart';


//filtered question list computed automatically base on filters

// FILTERS
final questionListFilterType = StateProvider<int>((ref) => 0);
final questionListFilterLevel = StateProvider<int>((ref) => 0);
final questionListFilterCategory = StateProvider<int>((ref) => 0);

// LIST COMPUTAION
final filteredQuestionList = Provider<List<Question>>((ref) {
  log('&&& Filtering question list... &&&');
  final int filterType = ref.watch(questionListFilterType);
  final int filterLevel = ref.watch(questionListFilterLevel);
  final int filterCategory = ref.watch(questionListFilterCategory);

  List<Question> qListGlobalFiltered = List.from(questionListGlobalConst);
  //FILTER BY TYPE
  // 0 = all, 1 = shown, 2 = notShown
  if (filterType != 0) {
    if (filterType == 1) {
      qListGlobalFiltered.removeWhere((e) => ref.read(userService).isQuestionInQListNew(e.id) == null);
    }
    if (filterType == 2) {
      qListGlobalFiltered.removeWhere((e) => ref.read(userService).isQuestionInNotShownList(e.id) == null);
    }
  }

  // FILTER BY LEVEL
  // int corresponds to level
  if (filterLevel != 0) {
    qListGlobalFiltered.removeWhere((e) => e.level != filterLevel);
  }

  // FILTER BY CATEGORY
  // int corresponds to index of category List<String>
  if (filterCategory != 0) {
    qListGlobalFiltered.removeWhere((e) => e.label != filterCategory);
  }


  return qListGlobalFiltered;
});
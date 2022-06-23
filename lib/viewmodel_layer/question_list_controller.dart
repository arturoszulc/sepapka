import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/question_list.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';

import '../model_layer/models/question.dart';


//filtered question list computed automatically base on filters

// FILTERS
final questionListFilterType = StateProvider<int>((ref) => 0);
final questionListFilterLevel = StateProvider<int>((ref) => 0);
final questionListFilterCategory = StateProvider<int>((ref) => 0);

//FILTERED LIST INDEX
final questionListIndex = StateProvider<int>((ref) => 0);

final questionListCurrentQuestion = Provider.autoDispose.family<Question, int>((ref, index) {
  final int index = ref.watch(questionListIndex);
  final int length = ref.watch(filteredQuestionList).length;
  log('Index: ${index.toString()}');
  log('Length: ${length.toString()}');
  if (index+1 > length) return ref.read(filteredQuestionList).last;
  return ref.read(filteredQuestionList)[index];
});

// FILTERED LIST COMPUTATION
final filteredQuestionList = Provider.autoDispose<List<Question>>((ref) {
  log('&&& Filtering question list... &&&');
  final int filterType = ref.watch(questionListFilterType);
  final int filterLevel = ref.watch(questionListFilterLevel);
  final int filterCategory = ref.watch(questionListFilterCategory);

  List<Question> qListGlobalFiltered = List.from(questionListGlobalConst);


  //FILTER BY TYPE
  // 0 = all, 1 = shown, 2 = notShown
  if (filterType != 0) {
    if (filterType == 1) {
      qListGlobalFiltered.removeWhere((e) => ref.read(userService).hiddenQuestionIds.contains(e.id));
    }
    if (filterType == 2) {
      qListGlobalFiltered.removeWhere((e) => !ref.read(userService).hiddenQuestionIds.contains(e.id));
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
  //SORT ALPHABETICALLY
  qListGlobalFiltered.sort((a, b) => a.q.toLowerCase().compareTo(b.q.toLowerCase()));

  return qListGlobalFiltered;
});


final questionListController = Provider<QuestionListController>((ref) {
  return QuestionListController(ref);
});

class QuestionListController {
  final Ref _ref;
  QuestionListController(this._ref) {
    log('^^^ QuestionListController initialized ^^^');
  }

  void showSingleQuestion(int index) {
    _ref.read(questionListIndex.notifier).state = index;
    _ref.read(routeController).navigate(MyScreen.listQuestionSingle);
  }

  void previousQuestion() {
    _ref.read(questionListIndex.notifier).state -=1;
  }

  void nextQuestion() {
    _ref.read(questionListIndex.notifier).state +=1;
  }

  bool isQuestionHidden(String qId) {
    return _ref.read(userService).hiddenQuestionIds.contains(qId);
  }

  void moveQuestionToHidden() {
    _ref.read(userService.notifier).moveQuestionToHidden(_ref.read(questionListCurrentQuestion).id);
    _ref.refresh(filteredQuestionList);
  }

  void removeQuestionFromHidden() {
    _ref.read(userService.notifier).removeQuestionFromHidden(_ref.read(questionListCurrentQuestion).id);
    _ref.refresh(filteredQuestionList);
  }

}
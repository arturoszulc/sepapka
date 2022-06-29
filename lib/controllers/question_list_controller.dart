import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/services/user_service.dart';
import 'package:sepapka/utils/question_list.dart';
import '../models/question.dart';



// FILTERS
final qListFilterType = StateProvider<int>((ref) => 0);
final qListFilterLevel = StateProvider<int>((ref) => 0);
final qListFilterCategory = StateProvider<int>((ref) => 0);

//FILTERED LIST CURRENT INDEX AND LENGTH
final qListCurrentQuestionIndex = StateProvider<int>((ref) => 0);
final qListFilteredLength = Provider.autoDispose<int>((ref) {
  return ref.watch(qListFiltered).length;
});

final qListCurrentQuestion = Provider.autoDispose<Question>((ref) {
  final int index = ref.watch(qListCurrentQuestionIndex);
  final int length = ref.watch(qListFilteredLength);
  if (index+1 > length) return Question.empty();
  return ref.read(qListFiltered)[index];
});

// FILTERED LIST COMPUTATION
final qListFiltered = Provider.autoDispose<List<Question>>((ref) {
  log('&&& Filtering question list... &&&');
  final int filterType = ref.watch(qListFilterType);
  final int filterLevel = ref.watch(qListFilterLevel);
  final int filterCategory = ref.watch(qListFilterCategory);

  List<Question> qListGlobalFiltered = List.from(questionListGlobalConst);


  //FILTER BY TYPE
  // 0 = all, 1 = shown, 2 = notShown
  if (filterType != 0) {
    if (filterType == 1) {
      qListGlobalFiltered.removeWhere((e) =>
          ref
              .read(userService)
              .hiddenQuestionIds
              .contains(e.id));
    }
    if (filterType == 2) {
      qListGlobalFiltered.removeWhere((e) =>
      !ref
          .read(userService)
          .hiddenQuestionIds
          .contains(e.id));
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


final questionListController = Provider.autoDispose<QuestionListController>((ref) {
  return QuestionListController(ref);
});

class QuestionListController {
  final Ref _ref;

  QuestionListController(this._ref) {
    log('^^^ QuestionListController initialized ^^^');
  }

  void showSingleQuestion(int index) {
    setIndex(index);
  }

  //method that recalculates qListCurrentIndex
  setIndex(int? index) {
    //why ,,int?"? Because sometimes just want to check if index is not out of range
    int currentIndex = _ref.read(qListCurrentQuestionIndex);
    final qListLength = _ref.read(qListFilteredLength);
    //first set desired index if provided
    if (index != null) currentIndex = index;
    //just if index is not out of range
    if (currentIndex < 0) currentIndex = 0;
    if (currentIndex + 1 > qListLength) currentIndex = 0;
    //set desired index
    _ref.read(qListCurrentQuestionIndex.notifier).state = currentIndex;
  }

  void previousQuestion() {
    setIndex(_ref.read(qListCurrentQuestionIndex) - 1);
  }

  void nextQuestion() {
    setIndex(_ref.read(qListCurrentQuestionIndex) + 1);
  }

  bool isQuestionHidden(String qId) {
    return _ref
        .read(userService)
        .hiddenQuestionIds
        .contains(qId);
  }

  void moveQuestionToHidden(String id) {
    _ref.read(userService.notifier).moveQuestionToHidden(id);
    _ref.refresh(qListFiltered);
    setIndex(null);
  }

  void removeQuestionFromHidden(String id) {
    _ref.read(userService.notifier).removeQuestionFromHidden(id);
    _ref.refresh(qListFiltered);
    setIndex(null);
  }

}
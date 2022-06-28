import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/quiz_service.dart';
import 'package:sepapka/viewmodel_layer/app_state_controller.dart';

import '../model_layer/models/button_map.dart';
import '../model_layer/models/question.dart';
import '../model_layer/services/user_service.dart';
import '../utils/consts/colors.dart';

//// Percent progress calculation ////
final quizTotalQuestions = StateProvider.autoDispose<int>((ref) => ref.watch(quizQuestionList).length);
final quizNumOfAnsweredQuestions = StateProvider.autoDispose<int>((ref) => 0);

final quizPercentProgress = Provider.autoDispose<double>((ref) {
  final int totalNumOfQuestions = ref.watch(quizTotalQuestions);
  final int questionIndex = ref.watch(quizNumOfAnsweredQuestions);
  log('Quiz totalQuestions: $totalNumOfQuestions');
  log('Quiz currentIndex: $questionIndex');
  if (questionIndex == 0) return 0.0;
  return questionIndex/totalNumOfQuestions;
  // return 0.5;
});
// Quiz final score calculation

final quizCorrectAnswers = StateProvider<int>((ref) => 0);

final quizFinalScore = Provider.autoDispose<String>((ref) {
  final int numberOfQuestions = ref.read(quizTotalQuestions);
  final int numberOfRightAnswers = ref.read(quizCorrectAnswers);
  double scoreDouble = (numberOfRightAnswers / numberOfQuestions) * 100;
  String scoreString = scoreDouble.toStringAsFixed(1);
  return scoreString;
});

final quizLevel = StateProvider<int>((ref) => 0);
final quizCategory = StateProvider<int>((ref) => 0);

//Question list WITHOUT HIDDEN QUESTIONS
final quizQuestionListGlobal =
    Provider<List<Question>>((ref) => ref.read(quizService).getQuizQuestionList());

//Count quiz questions by LEVEL
final numOfQuestionsByLevel = Provider<List<int>>((ref) {
  final List<Question> qList = ref.read(quizQuestionListGlobal);
  final List<int> numList = [0, 0, 0, 0];
  for (Question question in qList) {
    if (question.level == 1) numList[1] += 1;
    if (question.level == 2) numList[2] += 1;
    if (question.level == 3) numList[3] += 1;
  }
  numList[0] = numList[1] + numList[2] + numList[3];  //first number is total number of questions
  return numList;

});

//Count quiz questions by CATEGORY
final numOfQuestionsByCategory = Provider<List<int>>((ref) {
  final List<Question> qList = ref.read(quizQuestionListGlobal);
  final int qLevel = ref.watch(quizLevel);
  final List<int> numList = [0, 0, 0, 0, 0];

      if(qLevel != 0){ //this if/else must stay!
    for (Question question in qList) {
      if (question.level == qLevel) {
        if (question.label == 1) numList[1] += 1;
        if (question.label == 2) numList[2] += 1;
        if (question.label == 3) numList[3] += 1;
        if (question.label == 4) numList[4] += 1;
      }
    }
  } else {
        for (Question question in qList) {
            if (question.label == 1) numList[1] += 1;
            if (question.label == 2) numList[2] += 1;
            if (question.label == 3) numList[3] += 1;
            if (question.label == 4) numList[4] += 1;
        }
      }
  numList[0] = numList[1] + numList[2] + numList[3] + numList[4];
  return numList;
});

//Prepare quiz Question list - deployed manually, one time
final quizQuestionList = Provider<List<Question>>((ref) {
  List<Question> qList = List<Question>.from(ref.read(quizQuestionListGlobal));
  final int chosenLevel = ref.read(quizLevel);
  final int chosenCategory = ref.read(quizCategory);
  //TODO: Fix this. No question have level=0, so when I choose all questions, I get an error

  if (chosenLevel > 0) {   //first filter by level, if it is chosen (greater than 0)
    qList = List<Question>.from([
    for (final q in qList)
      if (q.level == chosenLevel) ...[q]
  ]);
  }
  if (chosenCategory > 0) {   //next filter by category, if it is chosen (greater than 0)
    qList = List<Question>.from([
      for (final q in qList)
        if (q.label == chosenCategory) ...[q]
    ]);
  }
  qList.shuffle(); //lastly shuffle the list
  return qList;
});

//Current quiz Question
final quizCurrentQuestion =
Provider.autoDispose<Question>((ref) => ref.watch(quizQuestionList)[ref.watch(quizCurrentQuestionIndex)]);

//Current quiz question Status
final isQuestionAnswered = StateProvider.autoDispose<bool>((ref) => false); //for showing ,,next" button

final quizCurrentQuestionIndex = StateProvider.autoDispose<int>((ref) => 0); //current question

final bMapProvider = StateProvider<List<BMap>>((ref) => []); //current question BMap

////////////////////////////
//////// CONTROLLER ////////
////////////////////////////

final quizController = Provider.autoDispose<QuizController>((ref) => QuizController(ref));

class QuizController {
  final Ref _ref;

  QuizController(this._ref) {
    log('^^^ QuizController initialized ^^^');
  }

  void setLevel(int lvl) {
    _ref.read(quizLevel.notifier).state = lvl;
  }

  void setCategory(int cat) {
    _ref.read(quizCategory.notifier).state = cat;
  }

  void prepareSession() {
    // _ref.refresh(quizCurrentQuestionIndex); //reset current question index
    _ref.refresh(quizQuestionList); //prepare question list based on level and category
    prepareBMap(); //prepare BMap
  }

  void checkAnswer(String answer) {
    final Question currentQuestion = _ref.read(quizCurrentQuestion);
    final bool isAnswered = _ref.read(isQuestionAnswered);
    if (isAnswered) return; //if user already answered, do nothing
    if (currentQuestion.a1 == answer) {
      //right answer
      _ref.read(quizCorrectAnswers.notifier).state += 1; //for final score
    } else {
      //wrong answer
    }
    _ref.read(isQuestionAnswered.notifier).state = true; //set answered to true
    _ref.read(quizNumOfAnsweredQuestions.notifier).state += 1; //for percent progress calculation
    updateBMap(answer);
  }

  void nextQuestion() {
    //if it was the last question, finish quiz
    if (_ref.read(quizCurrentQuestionIndex.notifier).state+1 == _ref.read(quizTotalQuestions)) {
      finishQuiz();
      return;
    }
    //if not, get next question
    _ref.read(isQuestionAnswered.notifier).state = false;
    _ref.read(quizCurrentQuestionIndex.notifier).state += 1;
    prepareBMap();
  }

  void prepareBMap() {
    _ref.read(bMapProvider.notifier).state =
        _ref.read(quizService).getShuffledBMap(_ref.read(quizCurrentQuestion));
  }

  void updateBMap(String answer) {
    final Question currentQuestion = _ref.read(quizCurrentQuestion);
    _ref.read(bMapProvider.notifier).state = List<BMap>.from([
      for (final bMap in _ref.read(bMapProvider.notifier).state)
        if (bMap.answer == currentQuestion.a1) ...[
          BMap(answer: bMap.answer, color: rightButtonColor)
        ] else if (bMap.answer == answer) ...[
          BMap(answer: bMap.answer, color: wrongButtonColor)
        ] else ...[
          bMap
        ]
    ]);
    log('BMap after: ${_ref.read(bMapProvider)}');
  }

  void moveQuestionToHidden() {
    final String qId = _ref.read(quizCurrentQuestion).id;
    _ref.read(userService.notifier).moveQuestionToHidden(qId);
    nextQuestion();
  }

  void finishQuiz() {
    //set state and router will redirect automatically
    _ref.read(appStateNotifierProvider.notifier).quizFinished();
  }

  void resetQuiz() {
  }
}

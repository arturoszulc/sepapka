import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/quiz_service.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';

import '../model_layer/models/button_map.dart';
import '../model_layer/models/question.dart';
import '../model_layer/models/quiz_state_model.dart';
import '../utils/consts/colors.dart';


final sessionPercentIndicator = StateProvider.autoDispose<double>((ref) => 0.5);
final bMapProvider = StateProvider<List<BMap>>((ref) => []);
final quizController = StateNotifierProvider.autoDispose<QuizController, QuizState>((ref) => QuizController(ref));

class QuizController extends StateNotifier<QuizState> {
  final Ref _ref;
  QuizController(this._ref) : super(QuizState.initial()) {
   log('^^^ QuizController initialized ^^^');
  }

  List<int> get numOfQuestionsByLevel => _ref.read(quizService).countQuestionsByLevel();
  List<int> get numOfQuestionsByCategory => _ref.read(quizService).countQuestionsByCategory();
  Question get currentQuestion => state.questions[state.currentQuestionIndex];
  double get progressPercentSession => _ref.read(sessionPercentIndicator);
  void setLevel(int lvl) {
    state = state.copyWith(qLevel: lvl);
    _ref.read(routeController).navigate(MyScreen.quizChooseCategory);
  }

  void setCategory(int cat) {
    log('Category: $cat');
    state = state.copyWith(category: cat);
    getQuestions();
    log('Passed getQuestions');
    prepareBMap();
    _ref.read(routeController).navigate(MyScreen.quizQuestionSingle);
  }

  void getQuestions() {
    state = state.copyWith(
      questions: _ref.read(quizService).getQuizQuestions(state.qLevel, state.category)
    );
    state = state.copyWith(
      totalQuestions: state.questions.length
    );
  }

  void checkAnswer(String answer) {
    log('BMap before');
    log(_ref.read(bMapProvider.notifier).state.toString());
    if (state.isAnswered) return; //if user already answered, do nothing
    if (currentQuestion.a1 == answer) {
      //right answer
      state = state.copyWith(
        status: QuizStatus.rightAnswer,
        // selectedAnswer: answer,
        totalQuestionsCorrect: state.totalQuestionsCorrect+1,
      );
      // _ref.read(bMapProvider.notifier).state.firstWhere((element) => element.answer == answer).copyWith(color: rightButtonColor);

    } else {
      //wrong answer
      state = state.copyWith(
        status: QuizStatus.wrongAnswer,
      );
      //color wrong button
      // _ref.read(bMapProvider.notifier).state.firstWhere((element) => element.answer == answer)) = .copyWith(color: wrongButtonColor);
      // //color right button
      // _ref.read(bMapProvider.notifier).state.firstWhere((element) => element.answer == currentQuestion.a1).copyWith(color: rightButtonColor);
    }

    updateBMap(answer);

    // log('BMap after');
    // log(_ref.read(bMapProvider.notifier).state.toString());
    // _ref.read(bMapProvider.notifier).state =
    //     _ref.read(quizService).updateBMap(_ref.read(bMapProvider.notifier).state, answer);
  }

  void nextQuestion() {
    final count = state.currentQuestionIndex+1;
      // state.questions.removeAt(0);
      state = state.copyWith(
          status: QuizStatus.notAnswered,
        currentQuestionIndex: state.currentQuestionIndex + 1
      );
    log('CurrentQuestionindex: ${state.currentQuestionIndex}');
    prepareBMap();
  }

  void prepareBMap() {
    _ref.read(bMapProvider.notifier).state =
        _ref.read(quizService).getShuffledBMap(state.questions[state.currentQuestionIndex]);
      }

      void updateBMap(String answer) {
    _ref.read(bMapProvider.notifier).state = List<BMap>.from([
      for (final bMap in _ref.read(bMapProvider.notifier).state)
          if (bMap.answer == currentQuestion.a1) ...[
          BMap(answer: bMap.answer, color: rightButtonColor)
          ] else if (bMap.answer == answer) ...[
            BMap(answer: bMap.answer, color: wrongButtonColor)
        ]
        else ...[bMap]
    ]);
    log('BMap after: ${_ref.read(bMapProvider)}');
      }

  void startQuiz() {}

  void finnishQuiz() {
    _ref.read(routeController).navigate(MyScreen.sessionFinished);
  }

  void resetQuiz() {
    state = QuizState.initial();
  }

}
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/quiz_service.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';

import '../model_layer/models/button_map.dart';
import '../model_layer/models/question.dart';
import '../model_layer/models/quiz_state_model.dart';
import '../utils/consts/colors.dart';



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
  void setLevel(int lvl) {
    state = state.copyWith(qLevel: lvl);
    _ref.read(routeController).navigate(MyScreen.quizChooseCategory);
  }

  void setCategory(int cat) {
    log('Category: $cat');
    state = state.copyWith(category: cat);
    getQuestions();
    prepareBMap();
    _ref.read(routeController).navigate(MyScreen.quizQuestionSingle);
  }

  void getQuestions() {
    state = state.copyWith(
      questions: _ref.read(quizService).getQuizQuestions(state.qLevel, state.category)
    );
  }

  void checkAnswer(String answer) {
    if (state.status == QuizStatus.answered) return; //if user already answered, do nothing
    if (currentQuestion.a1 == answer) {
      //right answer
      state = state.copyWith(
        status: QuizStatus.answered,
        // selectedAnswer: answer,
        currentQuestionIndex: state.currentQuestionIndex+1,
        totalQuestionsCorrect: state.totalQuestionsCorrect+1,
      );
    } else {
      //wrong answer
      state = state.copyWith(
        status: QuizStatus.answered,
      );
    }
    _ref.read(bMapProvider.notifier).state =
        _ref.read(quizService).updateBMap(_ref.read(bMapProvider.notifier).state, answer);
  }

  void nextQuestion() {
    if (state.status == QuizStatus.answered) {
      state = state.copyWith(
          status: QuizStatus.notAnswered,
        currentQuestionIndex: state.currentQuestionIndex+1,
      );
    }
    prepareBMap();
  }

  void prepareBMap() {
    _ref.read(bMapProvider.notifier).state =
        _ref.read(quizService).getShuffledBMap(state.questions[state.currentQuestionIndex]);
      }

  void startQuiz() {}

  void finnishQuiz() {
    _ref.read(routeController).navigate(MyScreen.sessionFinished);
  }

  void resetQuiz() {
    state = QuizState.initial();
  }

}
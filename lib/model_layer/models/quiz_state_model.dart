import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/question.dart';


enum QuizStatus {
  initial,
  notAnswered,
  answered,
  complete,
}

// enum QuestionStatus {
//   notAnswered,
//   correctAnswer,
//   wrongAnswer,
// }

class QuizState {
  final QuizStatus status;
  final int qLevel;
  final int category;
  final List<Question> questions;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int totalQuestionsCorrect;
  final String selectedAnswer;


  const QuizState({
    required this.status,
    required this.qLevel,
    required this.category,
    required this.questions,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.totalQuestionsCorrect,
    required this.selectedAnswer,
  });

  factory QuizState.initial() {
    return const QuizState(
      status: QuizStatus.initial,
      qLevel: 0,
      category: 0,
      questions: [],
      currentQuestionIndex: 0,
      totalQuestions: 0,
      totalQuestionsCorrect: 0,
      selectedAnswer: '',
      // bMapList: [],
    );
  }

  QuizState copyWith({
    QuizStatus? status,
    int? qLevel,
    int? category,
    List<Question>? questions,
    int? currentQuestionIndex,
    int? totalQuestions,
    int? totalQuestionsCorrect,
    String? selectedAnswer,
    // List<BMap>? bMapList,
  }) {
    return QuizState(
      status: status ?? this.status,
      qLevel: qLevel ?? this.qLevel,
      category: category ?? this.category,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      totalQuestionsCorrect: totalQuestionsCorrect ?? this.totalQuestionsCorrect,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      // bMapList: bMapList ?? this.bMapList,
    );
  }
}

// class QuestionState {
//   final Question currentQuestion;
//   final QuestionStatus status;
//   final List<BMap> bMap;
//
//
//
//   bool get isAnswered => status == QuestionStatus.correctAnswer || status == QuestionStatus.wrongAnswer;
//
// }

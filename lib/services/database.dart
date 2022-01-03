import 'package:flutter/material.dart';
import 'package:sepapka/objects/question.dart';
import 'package:sepapka/objects/question_consts.dart';



class DatabaseService {



  //Get Question list
List<Question> getQuestionList() {
  List<Question> qList = [q1, q2, q3, q4, q5, q6];
  return qList;
}

  //Get Question by ID

Question getQuestionById(String id) {
  Question q;
  List<Question> qList = getQuestionList();
  q = qList.singleWhere((element) =>
    element.id == id);
  return q;
}






}
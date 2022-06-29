import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';

import '../models/question.dart';

class FileService {


  Future<Object> saveQuestionListToFile(List<Question> qListGlobal) async {
    debugPrint('/// SAVING QUESTION LIST TO FILE ///');

    //serialize object
    final String jsonFile = jsonEncode(qListGlobal);

    //get File
    File file = await getFile();

    //save JSON to file
    try {
      await file.writeAsString(jsonFile);
      return Success();
    }
    catch(e) {
      debugPrint(e.toString());
      return Failure(errorWritingFile);
    }
  }

  Future<Object> getQuestionListFromFile() async {

    //get file
  File file = await getFile();

  try{
    //read file
    String jsonFile = await file.readAsString();

    //decode file
    List<dynamic> dynamicList = jsonDecode(jsonFile);

    //convert to correct type
    List<Question> questionList = dynamicList.map((e) => Question.fromJson(e)).toList();
    debugPrint('/// Download qGlobalList form JSON: Success ///');
    return questionList;
  }
  catch(e) {
    debugPrint(e.toString());
    debugPrint('/// Download qGlobalList form JSON: Failure ///');
    return Failure(errorReadingFile);
  }


  }

  Future<File> getFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String fileName = 'QuestionList';
    File file = File('${dir.path}/$fileName');
    return file;
  }


}
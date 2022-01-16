import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sepapka/utils/consts.dart';

import '../models/question.dart';

class FileService {


  Future<bool> saveQuestionListToFile(List<Question> qListGlobal) async {
    print('ENTERED SAVE FILE');
    print('qListGlobal length: ${qListGlobal.length}');
    //serialize object
    final String jsonFile = jsonEncode(qListGlobal);
    print('JSON FILE JSON FILE');
    print(jsonFile);
    //save JSON to file

    File file = await getFile();
    try {
      await file.writeAsString(jsonFile);
      return true;
    }
    catch(e) {
      debugPrint(errorWritingFile);
      return false;
    }
    // print('FILE SAVED');
    // getQuestionListFromFile(file);

  }

  Future<List<Question>?> getQuestionListFromFile() async {

    //get file
  File file = await getFile();

  try{
    //read file
    String jsonFile = await file.readAsString();

    //decode file
    List<dynamic> dynamicList = jsonDecode(jsonFile);

    //convert to correct type
    List<Question> questionList = dynamicList.map((e) => Question.fromJson(e)).toList();

    return questionList;
  }
  catch(e) {
    //if read failed, return null
    debugPrint(errorReadingFile);
    return null;
  }


  }

  Future<File> getFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String fileName = 'QuestionList';
    File file = File('${dir.path}/$fileName');
    return file;
  }


}
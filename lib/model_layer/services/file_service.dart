import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/question.dart';

class FileService {


  Future saveQuestionListToFile(List<Question> qListGlobal) async {
    print('ENTERED SAVEQUESTIONLISTTOFILE');
    //serialize object
    final String jsonFile = jsonEncode(qListGlobal);

    //save JSON to file
    Directory dir = await getApplicationDocumentsDirectory();
    String fileName = 'QuestionList';
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(jsonFile);
    print('FILE SAVED');

  }

  // Future<List<Question>> getQuestionListFromFile() async {
  //   return
  // }


}
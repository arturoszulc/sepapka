import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/global_data.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/models/remark.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/file_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/methods.dart';

import '../../locator.dart';
import '../models/question.dart';

class QuestionService {
  //Services Injection
  final _userService = serviceLocator.get<UserService>();
  final _databaseService = serviceLocator.get<DatabaseService>();
  final _fileService = serviceLocator.get<FileService>();

  //Properties
  GlobalData? globalData; //downloaded from DB
  List<Question>? qListGlobal;
  List<Question> _qListCurrent = [];
  List<Question> _qListGlobalFiltered = [];
  int _qListCurrentStartLength = 0;
  int _currentSessionUserPoints = 0;
  // List<QMap> _todayPracticeList = [];
  Question? currentQuestion;

  //making those two properties below PRIVATE and creating getter and setter for them (to access them externally) is THE SAME
  //as making them public in the first place.
  //So there's point in making only those variables _private which shouldn't be modified in simple way

  QuestionStatus qStatus = QuestionStatus.noAnswer;
  QuestionType qType = QuestionType.learning; //default to learning
  QuestionFilter qFilter = QuestionFilter.alphabetical;
  int qLevel = 0;
  int qCategory = 0; //int corresponds to index of qList

  List<BMap> bMapList = []; //shuffled list of answers & colors for buttons
  bool isSessionFinished = false;

  //Getters
  // bool get isSessionFinished => _isSessionFinished;

  // List<Question> get qListGlobalFiltered => _qListGlobalFiltered;

  List<String> get qCategories => globalData!.qCategories;

  // List<BMap> get bMapList => _bMapList;

  //Methods

  Future<Object> prepareGlobalData() async {
    //Get GlobalData from DB
    try {
      globalData = await _databaseService.getGlobalData();
    } catch (e) {
      debugPrint(e.toString());
      return Failure(errorGetGlobalData);
    }

    //send current rank names and thresholds to userService
    _userService.prepareRanks(globalData!.rankNames, globalData!.rankThresholds);

    //compare questionVersion from DB with those in LoggedUser object
    //retreive list of outdated QuestionLists
    List<int> outdatedQLists = _userService.compareQVersion(globalData!.qVersions);

    //get Question List based on compareResult
    Object getQuestionResult = await getGlobalQuestionList(outdatedQLists);
    if (getQuestionResult is Failure) return getQuestionResult;

    //update qListGlobal variable
    qListGlobal = getQuestionResult as List<Question>;

    //update local user question version and qNewList (if there any any new questions)
    _userService.updateQVersion(globalData!.qVersions);
    await _userService.updateQNewLists(qListGlobal!);

    debugPrint('/// QuestionService: Finished preparing GlobalData ///');
    return Success();
  }

  Future<Object> getGlobalQuestionList(List<int> outdatedQLists) async {
    // if all question lists are up to date, try to take questions from local JSON file
    if (outdatedQLists.isEmpty) {
      Object getLocalQuestionResult = await _fileService.getQuestionListFromFile();
      if (getLocalQuestionResult is List<Question>) {
        return getLocalQuestionResult;
      }
      //if reading file failed, then new lists from DB has to be downloaded
      //to do this, fill outdatedQList with lists to download
      else {
        if (_userService.loggedUser!.isPro) {
          outdatedQLists.add(1);
        } else {
          outdatedQLists.addAll([2,3]);
        }

      }


    }

    //Initializing list that will allow merging couple of lists from DB
    List<Question> questionListFromDB = [];

    for (int outdatedList in outdatedQLists)
      {
        List<Question>? questionList = await _databaseService.getQuestionList(list: outdatedList);
        //if failed to download, interrupt whole method
        if (questionList == null) return Failure(errorGetQListFromDB);
        //if succeeded, add it to main list
        questionListFromDB += questionList;
      }

    //after downloading all question lists, save questions to local JSON file
    Object saveQuestionToFileResult = await _fileService.saveQuestionListToFile(questionListFromDB);
    if (saveQuestionToFileResult is Failure) return saveQuestionToFileResult;
    return questionListFromDB;
  }

  setQuestionType(QuestionType type) {
    qType = type;
  }
  setQuestionCategory(int catNumber) {
    qCategory = catNumber;
  }
  setQuestionLevel(int level) {
    qLevel = level;
  }


  prepareSession() async {

    //reset isSessionFinished flag
    isSessionFinished = false;

    //clear the old qlistCurrent
    _qListCurrent.clear();
    //reset current points counter
    _currentSessionUserPoints = 0;

    ///////////////////////////////////
    //// REWRITE GETTING QUESTIONS ////
    //////////////////////////////////

    List<QMap> qMapList = [];



    if (_qType == QuestionType.learning) {
      //if user chose learning based on level, get QMaps from NewList
      qMapList = _userService.getQMapsFromNewList(_qLevel);
    }
    if (_qType == QuestionType.quiz) {
      //if user chose Practice, get today's practice
      qMapList = _todayPracticeList;
    }
    for (QMap qMap in qMapList) {
      _qListCurrent.add(qListGlobal!.firstWhere((question) => question.id == qMap.id));
    }
    //set starting length of _qListCurrent for session progress bar
    _qListCurrentStartLength = _qListCurrent.length;
  }

  Future checkAnswer(String answer) async {
    //remove question from _qListCurrent
    _qListCurrent.removeAt(0);

    //If right answer
    if (answer == _currentQuestion!.a1) {
      //set QuestionStatus
      _qStatus = QuestionStatus.rightAnswer;
      //Add one point to user
      _currentSessionUserPoints += 1;
      //set button color
      bMapList.firstWhere((element) => element.answer == answer).color = rightButtonColor;
      //move question to Practice List
      _userService.moveQMapToPractice(_currentQuestion!.id, qType, qLevel, true);
    }
    //if wrong answer
    else {
      //get question back, at the end of the current list
      _qListCurrent.add(_currentQuestion!);

      _qStatus = QuestionStatus.wrongAnswer;
      //set wrong button
      bMapList.firstWhere((element) => element.answer == answer).color = wrongButtonColor;
      //set right button
      bMapList.firstWhere((element) => element.answer == _currentQuestion!.a1).color =
          rightButtonColor;
      //move question to the end of it's list, to try again
      if (_qType == QuestionType.learning) {
        //if question was new, there's no point in updateing database
        // if i'm correct, delete this if statement
        // _userService.moveQuestionToNew(_currentQuestion!.id, qType, qLevel);
      }
      if (_qType == QuestionType.quiz) {
        //move but do not update date or fibNum
        _userService.moveQMapToPractice(_currentQuestion!.id, qType, qLevel, false);
      }
    }
  }


  Future<Object> getNextQuestion() async {
    //reset QuestionStatus
    _qStatus = QuestionStatus.noAnswer;

    //if there is a question on the list
    if (_qListCurrent.isNotEmpty) {
      debugPrint('Question IS on the list');
      //prepare question
      _currentQuestion = _qListCurrent.first;
      //create new BMap
      createBMap();
      //success means there's question to show
      return Success();
    } else {
      //if theres no questions left on the list
      return Failure();
    }
  }

  Future<Object> endSession() async {
    //if it was practice session, note the change
    if (qType == QuestionType.quiz) _hasTodayPracticeListChanged = true;
    _currentQuestion = null;
    isSessionFinished = true;
    //give user points
    _userService.addPoints(_currentSessionUserPoints);
    //update user
    Object updateResult = await _userService.updateLoggedUserInDb();
    if (updateResult is Failure) return updateResult;
    return Success();
  }

  double getProgressPercentSession() {
    return (_qListCurrentStartLength - _qListCurrent.length) / _qListCurrentStartLength;
  }

  //Below method was used to determine number shown on badge, on the Practice button
  // int howManyToPracticeToday() {
  //   if (_hasTodayPracticeListChanged) {
  //     _todayPracticeList = _userService.getTodayPracticeQMapList();
  //     _hasTodayPracticeListChanged = false;
  //   }
  //   return _todayPracticeList.length;
  // }

  createBMap() {
    if (_currentQuestion != null) {
      bMapList = [
        BMap(answer: _currentQuestion!.a1, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a2, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a3, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a4, color: normalButtonColor),
      ];
      //shuffle buttons
      bMapList.shuffle();
    } else {
      //reset QuestionStatus
      _qStatus = QuestionStatus.noAnswer;
    }
  }

  doNotShowThisQuestionAnymore() async {
    //remove question from _qListCurrent
    if (_qStatus == QuestionStatus.noAnswer) {
      //if question wasnt answered, remove if from current list
      _qListCurrent.removeAt(0);
      //else it means question was already removed, so dont do it
    }
    await _userService.moveQMapToNotShown(_currentQuestion!.id, qType, qLevel);
  }

  Future<Object> resetUserProgress() async {
    //clear user lists
    await _userService.wipeUser();

    //update qNewList
    await _userService.updateQNewLists(qListGlobal!);
    return Success();
  }

  Future<Object> sendQuestionRemark(String remark) async {
    //validate data
    Object validateResult = validateRemark(remark);
    if (validateResult is Failure) return validateResult;
    try {
    _databaseService.sendQuestionRemark(Remark(
      date: DateTime.now(),
      question: _currentQuestion!.id,
      text: remark,
    ));
    return Success();
  }
  catch(e) {
      debugPrint(e.toString());
      return Failure(errorSendingRemark);
  }

  }

  getFilteredQuestionList(QuestionFilter filter) {
    qFilter = filter;
    _qListGlobalFiltered.clear();

    switch (filter) {
      case QuestionFilter.alphabetical:
        _qListGlobalFiltered = List<Question>.from(qListGlobal!);
        _qListGlobalFiltered.sort((a, b) => a.q.compareTo(b.q));
        break;
      case QuestionFilter.allNew:
        qListGlobal!.map((e) {
          if (_userService.isQuestionInQListNew(e.id) != null)
              // _userService.isQuestionInNew2(e.id) != null ||
              // _userService.isQuestionInNew3(e.id) != null
          {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.allPractice:
        qListGlobal!.map((e) {
          if (_userService.isQuestionInPracticeList(e.id) != null) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.allNotShown:
        qListGlobal!.map((e) {
          if (_userService.isQuestionInNotShownList(e.id) != null) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.level1:
        qListGlobal!.map((e) {
          if (e.level == 1) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.level2:
        qListGlobal!.map((e) {
          if (e.level == 2) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.level3:
        qListGlobal!.map((e) {
          if (e.level == 3) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.labelName1:
        qListGlobal!.map((e) {
          if (e.labels[0] == labelName1) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.labelName2:
        qListGlobal!.map((e) {
          if (e.labels[0] == labelName2) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.labelName3:
        qListGlobal!.map((e) {
          if (e.labels[0] == labelName3) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
      case QuestionFilter.labelName4:
        qListGlobal!.map((e) {
          if (e.labels[0] == labelName4) {
            _qListGlobalFiltered.add(e);
          }
        }).toList();
        break;
    }
  }
}

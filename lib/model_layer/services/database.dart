import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';

import '../question.dart';


class DatabaseService {

  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    debugPrint('DATABASESERVICE getUserData method deployed');
    //ZAKOMENTOWAC
    List<Question> qList = [q1, q2, q3, q4, q5, q6];
    return LoggedUser(
      documentId: uid,
      qListVersion: 1,
      qListNew: [
        QMap(id: qList[0].id, dateModified: '2021-00-00', numberFib: 0),
      ],
      qListPractice: [
        QMap(id: qList[1].id, dateModified: '2021-00-00', numberFib: 0),
        QMap(id: qList[2].id, dateModified: '2021-00-00', numberFib: 0),
        QMap(id: qList[3].id, dateModified: '2021-00-00', numberFib: 0),

      ],
      qListDeleted: [
        QMap(id: qList[4].id, dateModified: '2021-00-00', numberFib: 0),
        QMap(id: qList[5].id, dateModified: '2021-00-00', numberFib: 0),

      ],
    );
    //
    //   //ODKOMENTOWAC
    //   // var doc = await usersCollection.doc(uid).get();
    //   // return LoggedUser(
    //   //   documentId: doc.id,
    //   //   username: doc.get(USER_USERNAME),
    //   //   firstName: doc.get(USER_FIRSTNAME),
    //   //   lastName: doc.get(USER_LASTNAME),
    //   //   isAdmin: doc.get(USER_ISADMIN),
    //   //   isDeleted: doc.get(USER_ISDELETED),
    //   //   companyId: doc.get(USER_COMPANY_ID),
    //   //   companyRole: doc.get(USER_COMPANY_ROLE),
    //   // );
    // }
    //
    // //Get Question Version
    // int getQuestionVersion() {
    //   int version = questionVersionDB;
    //   return version;
    // }
    //
    // //Get Question list
    // List<Question> getQuestionList() {
    //   List<Question> qList = [q1, q2, q3, q4, q5, q6];
    //   debugPrint('QuestionList imported from DB');
    //   return qList;
    // }
    //
    // //Get Question by ID
    //
    // Question getQuestionById(String id) {
    //   Question q;
    //   List<Question> qList = getQuestionList();
    //   q = qList.singleWhere((element) => element.id == id);
    //   return q;
    // }
  }
}
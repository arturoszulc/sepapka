import 'package:flutter/foundation.dart';
import 'package:sepapka/models/logged_user.dart';
import 'package:sepapka/models/question.dart';
import 'package:sepapka/models/question_consts.dart';

class DatabaseService {
  //Get user data
  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    debugPrint('DATABASESERVICE getUserData method deployed');
    //ZAKOMENTOWAC
    List<Question> qList = getQuestionList();
    debugPrint(qList[0].id);
    return LoggedUser(
      documentId: uid,
      qVersion: 1,
      qNew: [
        {'id': qList[0].id}
      ],
      qUnknown: [
        {'id': qList[1].id},
        {'id': qList[2].id},
        {'id': qList[3].id}
      ],
      qKnown: [
        {'id': qList[4].id},
        {'id': qList[5].id}
      ],
    );

    //ODKOMENTOWAC
    // var doc = await usersCollection.doc(uid).get();
    // return LoggedUser(
    //   documentId: doc.id,
    //   username: doc.get(USER_USERNAME),
    //   firstName: doc.get(USER_FIRSTNAME),
    //   lastName: doc.get(USER_LASTNAME),
    //   isAdmin: doc.get(USER_ISADMIN),
    //   isDeleted: doc.get(USER_ISDELETED),
    //   companyId: doc.get(USER_COMPANY_ID),
    //   companyRole: doc.get(USER_COMPANY_ROLE),
    // );
  }

  //Get Question Version
  int getQuestionVersion() {
    int version = questionVersionDB;
    return version;
  }

  //Get Question list
  List<Question> getQuestionList() {
    List<Question> qList = [q1, q2, q3, q4, q5, q6];
    debugPrint('QuestionList imported from DB');
    return qList;
  }

  //Get Question by ID

  Question getQuestionById(String id) {
    Question q;
    List<Question> qList = getQuestionList();
    q = qList.singleWhere((element) => element.id == id);
    return q;
  }
}

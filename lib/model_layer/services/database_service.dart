import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';

import '../models/question.dart';


class DatabaseService {

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  //CREATE USER DOCUMENT IN DATABASE
  Future<void> createUser(String uid) async {
    return await usersCollection
        .doc(uid)
        .set({
      'qVersion': 0,
      'qListNew': [],
      'qListPractice': [],
      'qListNotShown': [],
    }).then((value) =>
        print('User created'));
  }



  // //UPDATE USER DATA
  // Future<void> updateUser(LoggedUser user) async {
  //   return await usersCollection
  //       .doc(user.documentId)
  //       .set({
  //     'username': user.username,
  //     'firstName': user.firstName,
  //     'lastName': user.lastName,
  //     'isAdmin': user.isAdmin,
  //     'isDeleted': false,
  //     'companyRole': user.companyRole,
  //     'companyId': user.companyId,
  //   }).then((value) =>
  //       debugPrint('Technician updated'));
  // }


  // GET LOGGED USER DATA
  Future<LoggedUser?> getUserData(String uid) async {
    // return LoggedUser(
    //   documentId: uid,
    //   qVersion: 1,
    //   qListNew: [
    //     QMap(id: q1.id, dateModified: '2021-00-00', numberFib: 0),
    //     QMap(id: q2.id, dateModified: '2021-00-00', numberFib: 0),
    //   ],
    //   qListPractice: [
    //     QMap(id: q3.id, dateModified: '2021-00-00', numberFib: 0),
    //   ],
    //   qListNotShown: [
    //   ],
    // );
    //
    //   ODKOMENTOWAC
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      qVersion: doc.get(userQVersion),
      qListNew: doc.get(userQListNew),
      qListPractice: doc.get(userQListPractice),
      qListNotShown: doc.get(userQListNotShown),
    );
  }
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

  //Get question version
  Future<int?> getQuestionVersion() async {
    return questionVersionDB;
  }
  //Get question list
  Future<List<Question>> getQuestionList() async {
    return questionListDB.map((doc) {
      return Question(
          id: doc.id,
          q: doc.q,
          a1: doc.a1,
          a2: doc.a2,
          a3: doc.a3,
          a4: doc.a4,
          label: doc.label,
          level: doc.level);
    }).toList();
  }

}
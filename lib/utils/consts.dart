import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/question.dart';



// const List<String> rankNames = ['uczeń','praktykant','elektryk'];
// const List<int> rankUpgradeThresholds = [4,8,50];



//Button colors
const Color normalButtonColor = Colors.yellow;
const Color wrongButtonColor = Colors.redAccent;
Color rightButtonColor = Colors.green.shade500;

//LoggedUser model properties
const String userQVersion = 'qVersion';
const String userUsername = 'username';
const String userIsPro = 'isPro';
const String userRankLevel = 'rankLevel';
const String userRankTotalPoints = 'rankTotalPoints';
const String userQListNew1 = 'qListNew1';
const String userQListNew2 = 'qListNew2';
const String userQListNew3 = 'qListNew3';
const String userQListPractice = 'qListPractice';
const String userQListNotShown = 'qListNotShown';

//Question model properties
const String questionQ = 'q';
const String questionA1 = 'a1';
const String questionA2 = 'a2';
const String questionA3 = 'a3';
const String questionA4 = 'a4';
const String questionLabels = 'labels';
const String questionLevel = 'level';
const String questionAssetPath = 'assetPath';

//GlobalData model properties
const String globalDataQVersionFree = 'qVersionFree';
const String globalDataQVersionPro = 'qVersionPro';
const String globalDataRankNames = 'rankNames';
const String globalDataRankThresholds = 'rankThresholds';

//Remark model properties
const String remarkDate = 'date';
const String remarkQuestion = 'question';
const String remarkText = 'text';



//////Errors

//UserService Errors
const String usernameCharValidationError = 'Nazwa użytkownika może zawierać tylko litery i cyfry';
const String usernameLengthError = 'Nazwa użytkownika musi zawierać od 3 do 16 znaków';
const String usernameTakenError = 'Ta nazwa użytkownika jest już zajęta';

//QuestionService Errors
const String errorRemarkTooShort = 'Wpisz uwagę';
const String errorRemarkChars = 'Usuń znaki specjalne';
const String errorSendingRemark = '### Wysyłanie uwagi nie powiodło się ###';

//DB Errors
const String errorDbGeneric = 'Operacja się nie powiodła. Spróbuj później';
const String errorDbConnection = '### Brak połączenia z bazą danych ###';
const String errorGetGlobalData = '### Nie udało się pobrać danych z serwera ###';
const String errorGetQListFromDB =
    '### Nie można pobrać listy pytań. Sprawdź połączenie z internetem ###';
const String errorGetUserDataFromDB =
    '### Błąd pobierania danych użytkownika. Spróbuje utworzyć nowego... ### ';
const String errorUpdateUserInDb = '### Nie udało się zaktualizować danych użytkownika ###';
const String errorRollBackUser = 'Coś poszło nie tak. Spróbuj zalogować się ponownie do aplikacji';

//AuthService Errors
const String errorSignIn = '### AuthService.signInEmail() error: ';
const String errorSignOut = '### AuthService.signOut() error: ';

//FileService error
const String errorWritingFile =
    '### FileService.saveQuestionListToFile() error: Couldnt write data to file ###';
const String errorReadingFile =
    '### FileService.getQuestionListFromFile() error: Couldnt read data from file ###';

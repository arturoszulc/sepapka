import 'package:get_it/get_it.dart';
import 'package:sepapka/model_layer/services/auth.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/question.dart';
import 'package:sepapka/model_layer/services/user_service.dart';

final serviceLocator = GetIt.instance; // GetIt.I is also valid

void setupGetIt(){
  serviceLocator.registerLazySingleton<AuthService>(
          () => AuthService());
  serviceLocator.registerLazySingleton<UserService>(
          () => UserService());
  serviceLocator.registerLazySingleton<DatabaseService>(
          () => DatabaseService());
  serviceLocator.registerLazySingleton<QuestionService>(
          () => QuestionService());
}
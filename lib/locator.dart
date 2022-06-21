import 'package:get_it/get_it.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/file_service.dart';
import 'package:sepapka/model_layer/services/purchase_service.dart';
import 'package:sepapka/model_layer/services/quiz_service.dart';
import 'package:sepapka/model_layer/services/storage_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';

import 'model_layer/services/validation_service.dart';

final serviceLocator = GetIt.instance; // GetIt.I is also valid

void setupGetIt(){
  serviceLocator.registerLazySingleton<AuthService>(
          () => AuthService());
  serviceLocator.registerLazySingleton<UserService>(
          () => UserService());
  serviceLocator.registerLazySingleton<DatabaseService>(
          () => DatabaseService());
  serviceLocator.registerLazySingleton<QuizService>(
          () => QuizService());
  serviceLocator.registerLazySingleton<FileService>(
          () => FileService());
  serviceLocator.registerLazySingleton<ValidationService>(
          () => ValidationService());
  serviceLocator.registerLazySingleton<PurchaseService>(
          () => PurchaseService());
  serviceLocator.registerLazySingleton<StorageService>(
          () => StorageService());
  // serviceLocator.registerLazySingleton<RouteService>(
  //         () => RouteService());
}
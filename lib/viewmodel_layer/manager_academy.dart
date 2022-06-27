//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sepapka/model_layer/services/storage_service.dart';
//
// import '../locator.dart';
//
// final academyManager = ChangeNotifierProvider<AcademyManager>((ref) {
//   return AcademyManager();
// });
//
//
// class AcademyManager extends ChangeNotifier {
//
//   StorageService _storageService = serviceLocator.get<StorageService>();
//
//
//
//
//   getFileName() {
//     _storageService.getFileName();
//   }
// }
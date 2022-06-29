//
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
//
// import 'package:firebase_storage/firebase_storage.dart';
//
// class StorageService {
//
//   final storageRef = FirebaseStorage.instance.ref('academy');
//   late ListResult futureFiles;
//
//   getFileName() async {
//     final fileReference = storageRef.child("academy_global_data/data.json");
//
//     try {
//       const oneMegabyte = 1024 * 1024;
//       final Uint8List? data = await fileReference.getData(oneMegabyte);
//       String jsonFile = String.fromCharCodes(data!);
//       debugPrint('JSON FILE:');
//       debugPrint(jsonFile);
//
//     } on FirebaseException catch (e) {
//       debugPrint('### STORAGE SERVICE ERROR: ${e.toString()} ###');
//     }
//
//
//
//     // //listing all files in directory reference
//     // futureFiles = await fileReference.listAll();
//
//
//     // debugPrint('futureReference: ${futureFiles.items}');
//   }
//
// }
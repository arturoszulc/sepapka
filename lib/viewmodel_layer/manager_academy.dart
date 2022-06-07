


import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/storage_service.dart';

import '../locator.dart';

class AcademyManager extends ChangeNotifier {

  StorageService _storageService = serviceLocator.get<StorageService>();




  getFileName() {
    _storageService.getFileName();
  }
}
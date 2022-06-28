

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/input_validation_model.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/model_layer/services/validation_service.dart';
import 'package:sepapka/viewmodel_layer/quiz_controller.dart';

import '../model_layer/models/remark.dart';
import 'app_state_controller.dart';


final remarkState = StateProvider<InputValidationModel>((ref) =>  const InputValidationModel(null, null));
final remarkErrorState = StateProvider.autoDispose<String>((ref) => '');


final remarkController = Provider<RemarkController>((ref) => RemarkController(ref));

class RemarkController {
  final Ref _ref;
  RemarkController(this._ref);


  void setRemarkError(String? error) {
    _ref.read(remarkErrorState.notifier).state = error ?? '';
  }

  void validateRemark(String val) {
    final InputValidationModel result = _ref.read(validationService).validateRemark(val);
    _ref.read(remarkState.notifier).state = result;
  }

  void sendRemark() {
    final Remark remark = buildRemark();
    _ref.read(databaseService).sendQuestionRemark(remark);
  }

  Remark buildRemark() {
    return Remark(
        userId: _ref.read(userService).id,
        appV: _ref.read(appVersionProvider).value ?? '',
        date: DateTime.now(),
        question: _ref.read(quizCurrentQuestion).q,
        text: _ref.read(remarkState).value ?? '');
  }


}
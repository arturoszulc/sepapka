import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/appState.dart';

final appState = Provider<AppState>((ref) => )

final appStateController = Provider<AppStateController>((ref) {
  return AppStateController();
});

class AppStateController {


}


class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState.initial());

}
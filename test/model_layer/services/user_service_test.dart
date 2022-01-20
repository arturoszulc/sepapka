import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import '../models/mocked_objects.dart';

void main() {
  mockSetupGetIt();
  UserService userService = UserService();

  setUp(() {});
  tearDown(() {});

  test('setLoggedUserChanged test', () {

    userService.setLoggedUserChanged(true);

    expect(userService.loggedUserChanged, true);

  });

}
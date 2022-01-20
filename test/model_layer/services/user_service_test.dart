import 'package:flutter_test/flutter_test.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import '../models/mocked_objects.dart';

void main() {

  // MockDataBaseService mockDataBaseService = MockDataBaseService();
  UserService userService = UserService.mock();

  setUp(() {});
  tearDown(() {});

  test('setLoggedUserChanged test', () {

    userService.setLoggedUserChanged(true);

    expect(userService.loggedUserChanged, true);

  });

}
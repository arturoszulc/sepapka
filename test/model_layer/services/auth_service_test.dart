import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';

class MockUser extends Mock implements User {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
  return Stream.fromIterable([
    MockUser(),
  ]);
  }

}

void main() {


  final MockFirebaseAuth mockAuth = MockFirebaseAuth();
  final AuthService auth = AuthService();
  setupGetIt();
  tearDown(() {});

  test('User Stream test', () async {
  });

}

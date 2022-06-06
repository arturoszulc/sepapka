import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/utils/api_status.dart';

import '../mock.dart';

class MockUser extends Mock implements User {}
class MockUserCredential extends Mock implements UserCredential {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
  return Stream.fromIterable([
    MockUser(),
  ]);
  }

}

Future<void> main() async {

  setupFirebaseAuthMocks();
  final MockFirebaseAuth mockAuth = MockFirebaseAuth();
  final AuthService auth = AuthService.mocked(mockAuth);
  final MockUserCredential mockUserCredential = MockUserCredential();
  const String email = 'test@test.pl';
  const String password = '123456';
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  tearDown(() {});

  test('sign in', () async {
      when(
          mockAuth.signInWithEmailAndPassword(email: email, password: password)

      ).thenAnswer((_) async => mockUserCredential);
      
      expect(await auth.signInEmail(email, password) , Success());

  });

}

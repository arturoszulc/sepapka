import 'package:mockito/mockito.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';


//Mocked classes
class MockDataBaseService extends Mock implements DatabaseService {}
class MockLoggedUser extends Mock implements LoggedUser {}


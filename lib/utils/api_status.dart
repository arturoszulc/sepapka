class Success {
  int? code;
  Object? object;

  Success({this.code, this.object});
}

class Failure {
  int? code;
  String? errorResponse;


  Failure({this.code, this.errorResponse});
}
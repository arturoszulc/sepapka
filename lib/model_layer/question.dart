class Question {
  String id;
  String q;
  String a1;
  String a2;
  String a3;
  String a4;
  List<String> labels;
  int level;

  Question(
      {required this.id,
      required this.q,
      required this.a1,
      required this.a2,
      required this.a3,
      required this.a4,
      required this.labels,
      required this.level,});
}

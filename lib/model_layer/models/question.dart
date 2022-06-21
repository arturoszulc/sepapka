class Question {
  final String id;
  final String q;
  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final int label;
  final int level;
  final String assetPath;

  Question({
    required this.id,
    required this.q,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.a4,
    required this.label,
    required this.level,
    required this.assetPath,
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        q = json['q'],
        a1 = json['a1'],
        a2 = json['a2'],
        a3 = json['a3'],
        a4 = json['a4'],
        label = json['label'],
        level = json['level'],
        assetPath = json['assetPath'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'q': q,
        'a1': a1,
        'a2': a2,
        'a3': a3,
        'a4': a4,
        'label': label,
        'level': level,
        'assetPath': assetPath,
      };

  @override
  toString() {
    return 'id: $id';
}
}

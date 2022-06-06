class QMap {
  String? id;
  String dateModified;
  int fibNum;

  QMap({required this.id, required this.dateModified, required this.fibNum});


  convertToMap() {
    return {'id': id, 'dateModified': dateModified, 'fibNum': fibNum};
  }

  @override
  toString() {
    return '{id: $id, dateModified: $dateModified, fibNum: $fibNum';
  }
}

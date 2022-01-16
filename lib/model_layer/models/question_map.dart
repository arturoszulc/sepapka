class QMap {
  String? id;
  String dateModified;
  int numberFib;

  QMap({required this.id, required this.dateModified, required this.numberFib});


  convertToMap() {
    return {'id': id, 'dateModified': dateModified, 'numberFib': numberFib};
  }

  @override
  toString() {
    return '{id: $id, dateModified: $dateModified, numberFib: $numberFib';
  }
}

import 'package:sepapka/model_layer/models/question_map.dart';

convertMapToQMap(Map e) {
  return QMap(id: e['id'], dateModified: e['dateModified'], numberFib: e['numberFib']);
}
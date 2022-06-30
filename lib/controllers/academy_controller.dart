import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/models/academy/unit_lesson_model.dart';
import 'package:sepapka/utils/lessons_data/all_lessons.dart';


final chosenUnitId = StateProvider<String>((ref) => '');
final chosenLessonId = StateProvider<String>((ref) => '');



final unitsList = Provider.autoDispose<List<Unit>>((ref) {
  return academyUnits;
});

final chosenUnit = Provider<Unit>((ref) {
  final String unitId = ref.read(chosenUnitId);
  return academyUnits.firstWhere((unit) => unit.id == unitId, orElse: () => Unit.empty());
});

final chosenLesson = Provider<Lesson>((ref) {
  final Unit unit = ref.read(chosenUnit);
  final String lessonId = ref.read(chosenLessonId);
  return unit.lessons.firstWhere((lesson) => lesson.id == lessonId, orElse: () => Lesson.empty());
});


final academyController = Provider<AcademyController>((ref) => AcademyController());

class AcademyController {

}

//
//
//

// import 'package:sepapka/services/storage_service.dart';
//
// import '../locator.dart';
//
// final academyManager = ChangeNotifierProvider<AcademyManager>((ref) {
//   return AcademyManager();
// });
//
//
// class AcademyManager extends ChangeNotifier {
//
//   StorageService _storageService = serviceLocator.get<StorageService>();
//
//
//
//
//   getFileName() {
//     _storageService.getFileName();
//   }
// }
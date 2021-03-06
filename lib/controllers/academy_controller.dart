import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/models/academy/unit_lesson_model.dart';
import 'package:sepapka/services/user_service.dart';
import 'package:sepapka/utils/lessons_data/all_lessons.dart';


final chosenUnitIndex = StateProvider<int>((ref) => 0);
final chosenLessonIndex = StateProvider<int>((ref) => 0);

final isNextLessonAvailable = Provider<bool>((ref) {
  final unitLength = ref.watch(chosenUnit).lessons.length;
  final currentIndex = ref.watch(chosenLessonIndex);
  final isUserPro = ref.watch(userService).isPro;

  final bool reachedEnd = currentIndex+1 == unitLength;

  if (!isUserPro && currentIndex > 0) return false;
  if (reachedEnd) return false;
  return true;
});

final unitsList = Provider.autoDispose<List<Unit>>((ref) {
  return academyUnits;
});

final chosenUnit = Provider<Unit>((ref) {
  final int unitIndex = ref.watch(chosenUnitIndex);
  return academyUnits[unitIndex];
});

final chosenLesson = Provider<Lesson>((ref) {
  final Unit unit = ref.watch(chosenUnit);
  final int lessonIndex = ref.watch(chosenLessonIndex);
  return unit.lessons[lessonIndex];
});


final academyController = Provider<AcademyController>((ref) => AcademyController(ref));

class AcademyController {
    final Ref _ref;
    const AcademyController(this._ref);


    chooseUnit(int index) {
      _ref.read(chosenUnitIndex.notifier).state = index;
    }

  chooseLesson(int index) {
    _ref.read(chosenLessonIndex.notifier).state = index;
  }

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
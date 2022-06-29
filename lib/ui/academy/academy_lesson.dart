import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/consts/my_screens.dart';

class AcademyLesson extends StatelessWidget {
  const AcademyLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(MyScreen.academyIndex.name);
          }, icon: const Icon(Icons.menu_book)),
        ],
      ),
      body: const Center(
        child: Text('To jest lekcja w akademii'),
      ),
    );
  }
}




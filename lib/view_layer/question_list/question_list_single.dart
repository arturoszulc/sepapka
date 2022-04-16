import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/view_layer/custom_widgets/build_question.dart';

import '../../model_layer/models/question.dart';
import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';
import '../custom_widgets/settings_popupmenu.dart';
import '../custom_widgets/single_question_top_bar.dart';

class QuestionListSingle extends StatelessWidget {
  const QuestionListSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListSingle Screen built ***');

    // final manager = Provider.of<Manager>(context);
    final int index = Provider.of<Manager>(context).qListGlobalFilteredIndex;
    final int filteredListLength = context.read<Manager>().qListGlobalFiltered.length-1;
    Question? question = context.read<Manager>().getSingleFilteredQuestion();
    final bool isQuestionHidden = context.read<Manager>().isQuestionHidden(question?.id);

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.listQuestion),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.listQuestion),
          ),
          title: Text('Pytanie ${index+1} / ${filteredListLength+1}'),
          centerTitle: true,
          actions: [
            buildSettingsMenu(isQuestionHidden),
          ],
        ),
        body: question == null ? Container() : Column(
          children: [
            const SizedBox(height: 10.0,),
            Expanded(
              flex: 3,
              child: buildQuestion(question),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Odpowiedź:', style: TextStyle(fontSize: 16.0,)),
                  const SizedBox(height: 30,),
                  Text(question.a1, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

              ],),),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.navigate_before_outlined, size: 40,),
                onPressed: index == 0 ? null : () {
                  context.read<Manager>().showSingleFilteredQuestion(index-1);
                },
              ),
              IconButton(
                icon: const Icon(Icons.navigate_next_outlined, size: 40,),

                onPressed: index == filteredListLength ? null : () {
                  context.read<Manager>().showSingleFilteredQuestion(index+1);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

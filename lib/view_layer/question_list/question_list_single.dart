import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    int index = Provider.of<Manager>(context).qListGlobalFilteredIndex;
    int filteredListLength = context.read<Manager>().qListGlobalFiltered.length-1;
    final question = context.read<Manager>().qListGlobalFiltered[index];
    final bool isQuestionHidden = context.read<Manager>().isQuestionHidden(question.id);
    debugPrint('isQuestionHidden: $isQuestionHidden');

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
        body: Column(
          children: [
            const SizedBox(height: 10.0,),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                    child: Text(
                      question.q,
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      // maxLines: 3,
                    ),
                  ),
                  Expanded(
                    child: question.assetPath.isEmpty ? Container() :
                    Image.asset('assets/images/questions/${question.assetPath}',

                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container(
              color: Colors.grey,
              child: Column(

                children: [
                  const Text('Odpowiedź:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(question.a1),

              ],),
            ),),

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

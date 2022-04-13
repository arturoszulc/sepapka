import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';

class QuestionListSingle extends StatelessWidget {
  const QuestionListSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListSingle Screen built ***');

    // final manager = Provider.of<Manager>(context);
    int index = Provider.of<Manager>(context).qListGlobalFilteredIndex;
    int filteredListLength = context.read<Manager>().qListGlobalFiltered.length-1;
    final question = context.read<Manager>().qListGlobalFiltered[index];

    debugPrint('current index: $index');
    debugPrint('list length: $filteredListLength');

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.listQuestion),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.listQuestion),
          ),
          title: const Text('Question List Single'),
        ),
        body: Center(
          child: Text(question.q),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.navigate_before_outlined),
                onPressed: index == 0 ? null : () {
                  context.read<Manager>().showSingleFilteredQuestion(index-1);
                },
              ),
              IconButton(
                icon: const Icon(Icons.navigate_next_outlined),

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

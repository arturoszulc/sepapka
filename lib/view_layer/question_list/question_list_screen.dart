import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListScreen built ***');
    final manager = Provider.of<Manager>(context);
    List<Question> qListGlobalFiltered = manager.qListGlobalFiltered;

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(MyScreen.menu),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<Manager>().navigate(MyScreen.menu),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () => context.read<Manager>().navigate(Screen.listQuestionFilter),
            //     icon: const Icon(Icons.filter_list),
            //   ),
            // ],
            title: const Text('Lista pytań'),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Column(
            children: [
              InkWell(
                onTap: () => context.read<Manager>().navigate(MyScreen.listQuestionFilter),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Typ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(qTypeList[manager.filterType]),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Poz. trudności',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(qLevelList[manager.filterLevel]),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kategoria',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(qCategoryList[manager.filterCategory]),
                        ],
                      ),
                      const Icon(Icons.filter_list),
                      // IconButton(
                      //   padding: EdgeInsets.zero,
                      //   constraints: const BoxConstraints(),
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.filter_list),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: qListGlobalFiltered.isEmpty
                    ? const Center(
                        child: Text('Brak pytań'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: qListGlobalFiltered.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10.0),
                              title: buildTitle(context, qListGlobalFiltered[index]),
                              subtitle: buildSubtitle(context, qListGlobalFiltered[index]),
                              onTap: () {
                                manager.showSingleFilteredQuestion(index);
                                // context.read<Manager>().navigate(Screen.listQuestionSingle);
                              },
                            ),
                          );
                        }),
              ),
            ],
          )),
    );
  }
}

Widget buildTitle(BuildContext context, Question q) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, right: 0),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: Text(q.q, style: const TextStyle())),
        Expanded(
          child: Container(
              alignment: Alignment.centerRight,
              // color: Colors.grey,
              child: context.read<Manager>().getQuestionIcon(q.id)),
        ),
      ],
    ),
  );
}

Widget buildSubtitle(BuildContext context, Question q) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Text(
              qCategoryList[q.label],
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          color: labelColors[q.label]),
      Text(
        'poz. ${q.level.toString()}',
        // textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      // context.read<Manager>().getQuestionIcon(q.id),

      // SizedBox(width: 15.0),
      // Icon(Icons.new_releases, color: Colors.grey),
    ],
  );
}

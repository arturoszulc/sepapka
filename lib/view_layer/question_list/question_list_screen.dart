import 'package:flutter/cupertino.dart';
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
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.menu),
          ),
          actions: [
            IconButton(onPressed: () => context.read<Manager>().navigate(Screen.listQuestionFilter),
              icon: const Icon(Icons.filter_list),
            ),
          ],
          title: const Text('Lista pytań'),
          elevation: 0.0,
        ),
        body: qListGlobalFiltered.isEmpty ?
        const Center(child: Text('Brak pytań'),)
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Typ', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(qTypeList[manager.filterType]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Poz. trudności', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(qLevelList[manager.filterLevel]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kategoria', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(qCategoryList[manager.filterCategory]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                  itemCount: qListGlobalFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: buildTitle(qListGlobalFiltered[index]),
                        subtitle: buildSubtitle(context, qListGlobalFiltered[index]),
                        onTap: () {
                          manager.showSingleFilteredQuestion(index);
                          context.read<Manager>().navigate(Screen.listQuestionSingle);
                        },
                      ),
                    );
                  }),
                ),
              ],
            )



      ),
    );
  }
}

Widget buildTitle(Question q) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: Text(q.q, style: const TextStyle())),
        Expanded(
          child: Text('lvl ${q.level.toString()}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 2.0),
            child: Text(
              qCategoryList[q.label],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          ),
          color: labelColors[q.label]),
      context.read<Manager>().getQuestionIcon(q.id),

      // SizedBox(width: 15.0),
      // Icon(Icons.new_releases, color: Colors.grey),
    ],
  );
}

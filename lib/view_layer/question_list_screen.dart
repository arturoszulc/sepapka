import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<Manager>(context);
    final List<Question>? qListGlobal = manager.qListGlobalFiltered;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.read<Manager>().navigate(Screen.menu),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list),),
        ],
        title: const Text('Lista pytań'),
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: qListGlobal!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(qListGlobal[index].q, style: const TextStyle()),
                ),
                subtitle: buildSubtitle(qListGlobal[index]),
                // Row(
                //   children: //[Text('111'),Text('111'),]
                //   createSubtitle(qList[index], labelColors)
                // ),
                onTap: () {
                  // Navigator.pushNamed(context, '/question-single', arguments: {'id': qList[index].id});
                },
              ),
            );
          }),
    );
  }
}

Widget buildSubtitle(Question q) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 2.0),
            child: Text(
              q.labels[0],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          ),
          color: labelColors[q.labels[0]]),
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
      // SizedBox(width: 15.0),
      // Icon(Icons.new_releases, color: Colors.grey),
    ],
  );
}

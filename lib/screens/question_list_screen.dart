import 'package:flutter/material.dart';
import 'package:sepapka/models/question.dart';
import 'package:sepapka/models/question_consts.dart';
import 'package:sepapka/services/database.dart';
`
class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista pytań'),
        elevation: 0.0,
      ),
      body: BuildQuestionList(),
    );
  }


}



class BuildQuestionList extends StatefulWidget {
  const BuildQuestionList({Key? key}) : super(key: key);

  @override
  _BuildQuestionListState createState() => _BuildQuestionListState();
}

class _BuildQuestionListState extends State<BuildQuestionList> {
  DatabaseService db = DatabaseService();
  List<Question> qList = [];


  @override
  void initState() {
    qList = db.getQuestionList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('Question list built');


    return ListView.builder(
          itemCount: qList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(qList[index].q, style: TextStyle()),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.check, color: Colors.green,),
                        // SizedBox(width: 15.0),
                        // Icon(Icons.new_releases, color: Colors.grey),
                      ],
                    ),
                    // Row(
                    //   children: //[Text('111'),Text('111'),]
                    //   createSubtitle(qList[index], labelColors)
                    // ),
                    onTap: () {
                      Navigator.pushNamed(context, '/question-single', arguments: {'id': qList[index].id});
                    },
                  ),
                ),
              ],);
          });
    }

    List<Widget> createSubtitle(Question q, Map labelColors) {

    List<Widget> labels = [];

    for (var label in q.labels) {
      Color myColor = labelColors[label];
      labels.add(Card(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
      ), color: myColor),
      );
      labels.add(const SizedBox(width: 5.0,));
    }
    return labels;
    }


  }

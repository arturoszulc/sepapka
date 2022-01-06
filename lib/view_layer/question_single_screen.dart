import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/question.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


class QuestionSingleScreen extends StatelessWidget {
  const QuestionSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final manager = Provider.of<Manager>(context);
    Question? question = manager.singleKnownQuestion;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single question'),
      ),
      body: question == null ? const Center(child: Text('NO QUESTION FOUND'),) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(child: Text(question.q)),
            ElevatedButton(
              onPressed: () async {
                await manager.moveQuestionToPractice(question.id);

              },
              child: Text('Show answer'),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButton: !isExpanded ? Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget> [
      //     FloatingActionButton.extended(
      //       heroTag: 'known',
      //       backgroundColor: Colors.green,
      //       label: Text('UMIEM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      //       icon: Icon(Icons.check, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //     SizedBox(width: 10.0,),
      //     FloatingActionButton.extended(
      //       heroTag: 'unknown',
      //       backgroundColor: Colors.red,
      //       label: Text('NIE UMIEM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      //       icon: Icon(Icons.clear, color: Colors.white),
      //       onPressed: () {},
      //     )
      //   ],
      // ) : null,
    );
  }
}

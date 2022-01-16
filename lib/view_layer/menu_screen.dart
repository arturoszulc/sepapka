import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<Manager>().signOut();
              },
              icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await context.read<Manager>().prepareQuestion(QuestionType.newQuestion);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Nauka'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await context.read<Manager>().prepareQuestion(QuestionType.practiceQuestion);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Powtórka materiału'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/question-list');
                          },
                          child: Text('Lista pytań'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Text('LoggedUser ID: ${context.read<Manager>().loggedUser!.documentId}'),
            Text('LoggedUser qNew: ${context.read<Manager>().loggedUser!.qListNew.length}'),
            Text('LoggedUser qPractice: ${context.read<Manager>().loggedUser!.qListPractice.length}'),
            const SizedBox(height: 100.0),
            const Text(
              'Learning progress:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: context.read<Manager>().progressPercent,
                center: Text('${(context.read<Manager>().progressPercent*100).toString()} %'),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

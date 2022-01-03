import 'package:flutter/material.dart';
import 'package:sepapka/services/database.dart';

class QuestionSingleScreen extends StatefulWidget {
  const QuestionSingleScreen({Key? key}) : super(key: key);

  @override
  State<QuestionSingleScreen> createState() => _QuestionSingleScreenState();
}

class _QuestionSingleScreenState extends State<QuestionSingleScreen> {
  final DatabaseService db = DatabaseService();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final id = args['id'];
    final q = db.getQuestionById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
              child: isExpanded
                  ? Card(
                      child: ListTile(
                        // expandedAlignment: Alignment.centerLeft,
                        // childrenPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                        title: Text(
                          q.q,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Card(
                      child: Column(
                        children: [
                          ListTile(
                            // expandedAlignment: Alignment.centerLeft,
                            // childrenPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                            title: Text(
                              q.q,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            // expandedAlignment: Alignment.centerLeft,
                            // childrenPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                            title: Text(
                              q.a,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text('Show answer'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: !isExpanded ? Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          FloatingActionButton.extended(
            heroTag: 'known',
            backgroundColor: Colors.green,
            label: Text('UMIEM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton.extended(
            heroTag: 'unknown',
            backgroundColor: Colors.red,
            label: Text('NIE UMIEM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {},
          )
        ],
      ) : null,
    );
  }
}

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/question-list');
              },
              child: Text('Lista pytań'),
            ),
            ElevatedButton(

              onPressed: () {},
              child: Text('Losowe pytanie'),
            ),
          ],
        ),
      ),
    );
  }
}

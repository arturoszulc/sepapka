import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


class MenuChooseLevel extends StatelessWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings-screen');
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
                            await context.read<Manager>().startNew(qLevel: 1);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Poziom 1'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await context.read<Manager>().startNew(qLevel: 2);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Poziom 2'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await context.read<Manager>().startNew(qLevel: 3);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: const Text('Poziom 3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

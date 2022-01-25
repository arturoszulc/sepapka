import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


class MenuChooseLevel extends StatelessWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** MenuChooseLevel built ***');


    int countLevel1 = context.read<Manager>().qNewLeftLevel1;
    int countLevel2 = context.read<Manager>().qNewLeftLevel2;
    int countLevel3 = context.read<Manager>().qNewLeftLevel3;
    bool isUserPro = context.read<Manager>().loggedUser!.isPro;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPapka'),
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
                          child: Text('Poziom 1 ($countLevel1)'),
                        ),
                        ElevatedButton(
                          onPressed: !isUserPro ? null : () async {
                            await context.read<Manager>().startNew(qLevel: 2);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: Text('Poziom 2 ($countLevel2)'),
                        ),
                        ElevatedButton(
                          onPressed: !isUserPro ? null : () async {
                            await context.read<Manager>().startNew(qLevel: 3);
                            Navigator.pushNamed(context, '/question-single');
                          },
                          child: Text('Poziom 3 ($countLevel3)'),
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

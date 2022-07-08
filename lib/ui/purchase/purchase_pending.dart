import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/consts/colors.dart';
class PurchasePending extends StatelessWidget {
  const PurchasePending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Transakcja jest przetwarzana', style: Theme.of(context).textTheme.headline5,),
                const SizedBox(height: 30),
                const CircularProgressIndicator(
                  color: proColor,
                ),
                const SizedBox(height: 30,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Czekamy, aż sklep Play potwierdzi płatność...', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 30),
                const Text('Wróć tutaj, gdy płatność zostanie zakończona. Wtedy automatycznie otrzymasz dostęp do SEPapka Pro.', textAlign: TextAlign.center,),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) => Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: FloatingActionButton.extended(
                      backgroundColor: proColor,
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        context.pop();
                      },
                      label: const Text('Powrót do menu'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],);


  }
}

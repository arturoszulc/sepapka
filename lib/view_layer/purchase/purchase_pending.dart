import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';

class PurchasePending extends StatelessWidget {
  const PurchasePending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(MyScreen.menu),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<Manager>().navigate(MyScreen.menu),
            ),
            // title: const Text('Purchase Error'),
            // centerTitle: true,
          ),
          body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Transakcja jest przetwarzana', style: Theme.of(context).textTheme.headline5,),
              const SizedBox(height: 30),
              SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.primary,
                size: 50.0,
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Czekamy, aż sklep Play potwierdzi płatność...', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
            const SizedBox(height: 30),
            const Text('Wróć tutaj, gdy płatność zostanie zakończona. Wtedy automatycznie otrzymasz dostęp do SEPapka Pro.', textAlign: TextAlign.center,),

              ],),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<Manager>().navigate(MyScreen.menu);
            },
            label: const Text('Powrót do menu'),
          ),

        ));
  }
}

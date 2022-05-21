import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';

class PurchaseSuccess extends StatelessWidget {
  const PurchaseSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(Screen.menu),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<Manager>().navigate(Screen.menu),
            ),
            // title: const Text('Purchase Error'),
            // centerTitle: true,
          ),
          body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              // Icon(Icons.check_box, size: 36, color: Colors.green,),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Dzięki za dotychczasowe wsparcie mojej twórczości!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Z ogromną przyjemnością przekazuję Ci dożywotni dostęp do wszystkich funkcji mojej aplikacji. Mam nadzieję, że okażą się przydatne!', textAlign: TextAlign.center,),
              ),
            ],),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<Manager>().navigate(Screen.menu);
            }, label: const Text('Powrót do menu'),),

        ));
  }
}

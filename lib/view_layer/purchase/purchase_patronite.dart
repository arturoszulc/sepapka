import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';
import '../../utils/custom_widgets/sign_in_button.dart';
import '../../viewmodel_layer/manager.dart';

class PurchasePatronite extends StatelessWidget {
  PurchasePatronite({Key? key}) : super(key: key);

  String email = '';

  @override
  Widget build(BuildContext context) {
    debugPrint('*** PurchasePatronite Screen built ***');
    final manager = Provider.of<Manager>(context);
    final errorMsg = manager.errorMsg;

    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(Screen.chooseLevel),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.read<Manager>().navigate(Screen.chooseLevel),
            ),
            // title: const Text('Purchase Error'),
            // centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Jesteś Patronem?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Podaj adres e-mail, którego używasz jako wspierający na Patronite i odblokuj pełen dostęp do aplikacji.', textAlign: TextAlign.center,),
                  ),
                const SizedBox(height: 20.0),

                //pole EMAIL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    // initialValue: manager.emailRemind.value,
                    // controller: emailFieldController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adres e-mail',
                      // errorText: manager.emailRemind.error,
                    ),
                    onChanged: (val) {
                      // manager.validateEmailRemind(val);
                      email = val;
                    },
                    onTap: () => manager.setError(null),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    errorMsg,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10.0),
                SignInButton(
                    onPressed: () async {
                      debugPrint(email);
                      await manager.purchasePatronite(email);
                    },
                    label: 'Odblokuj dostęp'),
                // const SizedBox(height: 100),


                ],

                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text('Masz problem z odblokowaniem dostępu?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Napisz do mnie na kontakt@teoriaelektryki.pl i coś poradzimy :)', textAlign: TextAlign.center,),
                    ),
                  ],),
              ),
            ],
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   icon: const Icon(Icons.exit_to_app),
          //   onPressed: () {
          //     context.read<Manager>().navigate(Screen.menu);
          //   }, label: const Text('Powrót do menu'),),

        ));
  }
}

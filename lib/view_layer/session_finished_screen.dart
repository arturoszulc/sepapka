import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:provider/provider.dart';


class SessionFinished extends StatelessWidget {
  const SessionFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sesja zakończona!!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 30.0),
              //if user got promoted
              if (context.read<Manager>().isUserPromoted) Column(
                children: [
                  const Text('Gratulacje!'),
                  Text('Awansowałeś do rangi: ${context.read<Manager>().userRankName}'),
                ],
              ),

              const SizedBox(height: 30.0),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<Manager>().resetIsUserPromotedFLag();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Powrót'),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.exit_to_app)),
      ),
    );
  }
}

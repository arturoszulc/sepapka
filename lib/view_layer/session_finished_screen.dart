import 'package:flutter/material.dart';

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
                'GRATULACJE!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 30.0),
              const Text('Sesja ukończona!'),
              const SizedBox(height: 30.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.exit_to_app),
                label: Text('Powrót'),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.exit_to_app)),
      ),
    );
  }
}

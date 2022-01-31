import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SessionFinished extends StatelessWidget {
  const SessionFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text(
                'GRATULACJE!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Sesja ukończona'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Rozpocznij nową sesję'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Wyjdź'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





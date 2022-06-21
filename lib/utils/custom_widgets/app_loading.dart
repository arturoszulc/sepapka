import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('*** LoadingScreen built ***');
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Theme.of(context).colorScheme.primary,
          size: 50.0,
        ),
      ),
    );
  }
}

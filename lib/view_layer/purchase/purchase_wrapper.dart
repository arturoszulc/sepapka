import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/view_layer/purchase/purchase_error.dart';
import 'package:sepapka/view_layer/purchase/purchase_finished.dart';
import 'package:sepapka/view_layer/purchase/purchase_loading.dart';
import 'package:sepapka/view_layer/purchase/purchase_screen.dart';

import '../../model_layer/models/purchase_state_model.dart';
import '../../viewmodel_layer/purchase_Controller.dart';

class PurchaseWrapper extends StatelessWidget {
  const PurchaseWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
          builder: (context, ref, child) {
            switch (ref.watch(purchaseController.select((value) => value.status))) {
              case PurchaseStatus.loading:
              return const PurchaseLoading();
              case PurchaseStatus.error:
              return const PurchaseError();
              case PurchaseStatus.initialized:
              return const PurchaseScreen();
                break;

              case PurchaseStatus.finished:
                return const PurchaseFinished();
                break;
            }
          }
      ),
    );
  }
}

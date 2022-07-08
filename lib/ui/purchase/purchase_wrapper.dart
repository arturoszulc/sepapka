import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/ui/purchase/purchase_error.dart';
import 'package:sepapka/ui/purchase/purchase_finished.dart';
import 'package:sepapka/ui/purchase/purchase_loading.dart';
import 'package:sepapka/ui/purchase/purchase_pending.dart';
import 'package:sepapka/ui/purchase/purchase_screen.dart';

import '../../models/purchase_state_model.dart';
import '../../controllers/purchase_Controller.dart';

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
              case PurchaseStatus.pending:
              return const PurchasePending();
              case PurchaseStatus.finished:
                return const PurchaseFinished();

            }
          }
      ),
    );
  }
}

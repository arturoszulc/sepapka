import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/tabels/table_wire_symbols.dart';

import '../../../utils/consts/nav.dart';
import '../../../viewmodel_layer/manager.dart';

class WireSymbols extends StatelessWidget {
  const WireSymbols({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** WireSymbols built ***');
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return context.read<Manager>().navigate(Screen.knowledgeBase);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.read<Manager>().navigate(Screen.knowledgeBase);
              },
            ),
            title: const Text('Oznaczenia przewodów'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: 'polskie'),
              Tab(text: 'zharmonizowane'),
            ]),
          ),
          body: TabBarView(children: [
            buildSymbolTable(context, wireSymbolsPolish),
            buildSymbolTable(context, wireSymbolsHarmonized),
            // buildRankTop(context),
            // buildRankUser(context),
          ]),
        ),
      ),
    );
  }

  Widget buildSymbolTable(BuildContext context, Map<String, List<WireSymbol>> data) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    const double globalPadding = 10.0;
    const double tablePadding = 15.0;
    double firstCellWidth = (width - (2*globalPadding) - (2*tablePadding))*0.7;
    double secondCellWidth = (width - (2*globalPadding) - (2*tablePadding))*0.3;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
          // for (String key in wireSymbolsHarmonized.keys) buildWireSymbolTable()
          data.entries.map<Widget>((data) =>
              Padding(
                padding: const EdgeInsets.all(globalPadding),

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: tablePadding),
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: 0,
                headingRowHeight: 0,
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text(''))
                ],
                rows: data.value.map<DataRow>((e) =>
                (DataRow(cells: [
                  DataCell(Container(
                      // color: Colors.red,
                      width: firstCellWidth,
                      child: Text(e.description,))),
                  DataCell(Container(
                      // color: Colors.green,
                      width: secondCellWidth,
                      child: Text(e.symbol, textAlign: TextAlign.right,)))
                ]
                )),
                ).toList(),
              ),
            ),
            ],
          ),

        )).toList(),),
    );
  }


}

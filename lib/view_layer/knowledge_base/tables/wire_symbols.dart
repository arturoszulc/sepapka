import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/build_question_image.dart';
import 'package:sepapka/utils/tabels/table_wire_symbols.dart';

import '../../../utils/consts/my_screens.dart';
import '../../../utils/custom_widgets/line_spacing.dart';
import '../../../viewmodel_layer/manager.dart';

class WireSymbols extends StatelessWidget {
  const WireSymbols({Key? key}) : super(key: key);
  static const double globalPadding = 10.0;
  static const double tablePadding = 15.0;

  @override
  Widget build(BuildContext context) {
    debugPrint('*** WireSymbols built ***');
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return context.read<Manager>().navigate(MyScreen.knowledgeBase);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.read<Manager>().navigate(MyScreen.knowledgeBase);
              },
            ),
            title: const Text('Symbole przewodów'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: 'polskie'),
              Tab(text: 'zharmonizowane'),
            ]),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: globalPadding),
            child: TabBarView(children: [
              tabPolish(context),
              tabHarmonized(context),
              // buildRankTop(context),
              // buildRankUser(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget tabPolish(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Objaśnienia symboli',
            style: Theme.of(context).textTheme.headline5,
          ),
          lineSpacing(),
          ...buildSymbolTable(context, wireSymbolsPolish),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Przykłady',
            style: Theme.of(context).textTheme.headline5,
          ),
          lineSpacing(),
          ...polishExamples(),
        ],
      ),
    );
  }

  Widget tabHarmonized(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Sposób kodowania',
            style: Theme.of(context).textTheme.headline5,
          ),
          lineSpacing(),

          Padding(
            padding: const EdgeInsets.all(15),
            child: buildImage(context,
                'assets/images/knowledge_base/wire_symbols/wire_symbols_harmonized_template.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Objaśnienia symboli',
            style: Theme.of(context).textTheme.headline5,
          ),
          lineSpacing(),

          ...buildSymbolTable(context, wireSymbolsHarmonized),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Przykłady',
            style: Theme.of(context).textTheme.headline5,
          ),
          lineSpacing(),

          ...harmonizedExamples(),
        ],
      ),
    );
  }

  List<Widget> buildSymbolTable(BuildContext context, Map<String, List<WireSymbol>> data) {
    double width = MediaQuery.of(context).size.width;

    double firstCellWidth = (width - (2 * globalPadding) - (2 * tablePadding)) * 0.7;
    double secondCellWidth = (width - (2 * globalPadding) - (2 * tablePadding)) * 0.3;
    return data.entries
        .map<Widget>((data) => Column(
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
                    columns: const [DataColumn(label: Text('')), DataColumn(label: Text(''))],
                    rows: data.value
                        .map<DataRow>(
                          (e) => (DataRow(cells: [
                            DataCell(SizedBox(
                                width: firstCellWidth,
                                child: Text(
                                  e.description,
                                ))),
                            DataCell(SizedBox(
                                width: secondCellWidth,
                                child: Text(
                                  e.symbol,
                                  textAlign: TextAlign.right,
                                )))
                          ])),
                        )
                        .toList(),
                  ),
                ),
              ],
            ))
        .toList();
  }

  List<Widget> polishExamples() {
    return [
      wireSymbolExampleTemplate(
          symbol: 'LgY 450/750V ',
          description:
              'przewód miedziany, na napięcie 450/750 V, izolacja polwinitowa (PVC), linka do układania na stałe, jednożyłowy'),
      wireSymbolExampleTemplate(
          symbol: 'DY 450/750V ',
          description:
              'przewód miedziany, na napięcie 450/750 V, izolacja polwinitowa (PVC), drut'),
      wireSymbolExampleTemplate(
          symbol: 'OWY 300/500V',
          description:
              'przewód miedziany, na napięcie 300/500 V, izolacja polwinitowa (PVC), powłoka polwinitowa (PVC), linka do odbiorników ruchomych, jednożyłowy'),
      wireSymbolExampleTemplate(
          symbol: 'YAKY 4x16 0,6/1 kV',
          description:
              'kabel aluminiowy, na napięcie 600/1000 V, izolacja polwinitowa (PVC), powłoka polwinitowa (PVC), 4-żyłowy, przekrój 16mm\u00B2'),
      wireSymbolExampleTemplate(
          symbol: 'AsXSn 5x32 0,6/1 kV',
          description:
              'przewód aluminiowy, samonośny, na napięcie 600/1000 V, izolacja z polietylenu sieciowanego (XLPE), niepalny, 5-żył, przekrój 32mm\u00B2'),
    ];
  }

  List<Widget> harmonizedExamples() {
    return [
      wireSymbolExampleTemplate(
          symbol: 'H07 V-K',
          description:
              'przewód zharmonizowany, na napięcie 450/750 V, izolacja polwinitowa (PVC), linka do układania na stałe, jednożyłowy'),
      wireSymbolExampleTemplate(
          symbol: 'H07 V-U',
          description:
              'przewód zharmonizowany, na napięcie 450/750 V, izolacja polwinitowa (PVC), drut'),
      wireSymbolExampleTemplate(
          symbol: 'H05 VV-F',
          description:
              'przewód zharmonizowany, na napięcie 300/500 V, izolacja polwinitowa (PVC), powłoka polwinitowa (PVC), linka do odbiorników ruchomych, jednożyłowy'),
      wireSymbolExampleTemplate(
          symbol: 'H05 VV-F 3G1,5',
          description:
              'przewód zharmonizowany, na napięcie 300/500 V, izolacja polwinitowa (PVC), powłoka polwinitowa (PVC), linka do odbiorników ruchomych, 3-żyłowy, z żyłą ochronną, przekrój 1,5mm\u00B2'),
    ];
  }

  Widget wireSymbolExampleTemplate({required String symbol, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            symbol,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(description),
        ],
      ),
    );
  }

//OLD COPY

// Widget buildSymbolTable(BuildContext context, Map<String, List<WireSymbol>> data) {
//   double width = MediaQuery
//       .of(context)
//       .size
//       .width;
//   const double globalPadding = 10.0;
//   const double tablePadding = 15.0;
//   double firstCellWidth = (width - (2*globalPadding) - (2*tablePadding))*0.7;
//   double secondCellWidth = (width - (2*globalPadding) - (2*tablePadding))*0.3;
//   return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children:
//         data.entries.map<Widget>((data) =>
//             Padding(
//               padding: const EdgeInsets.all(globalPadding),
//
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(data.key, style: const TextStyle(fontWeight: FontWeight.bold)),
//               ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: tablePadding),
//             child: DataTable(
//               horizontalMargin: 0,
//               columnSpacing: 0,
//               headingRowHeight: 0,
//               columns: const [
//                 DataColumn(label: Text('')),
//                 DataColumn(label: Text(''))
//               ],
//               rows: data.value.map<DataRow>((e) =>
//               (DataRow(cells: [
//                 DataCell(Container(
//                     // color: Colors.red,
//                     width: firstCellWidth,
//                     child: Text(e.description,))),
//                 DataCell(Container(
//                     // color: Colors.green,
//                     width: secondCellWidth,
//                     child: Text(e.symbol, textAlign: TextAlign.right,)))
//               ]
//               )),
//               ).toList(),
//             ),
//           ),
//           ],
//         ),
//
//       )).toList(),),
//   );
// }

}

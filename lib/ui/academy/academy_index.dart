import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/controllers/index_controller.dart';
import 'package:sepapka/models/academy/index_entry_model.dart';

class AcademyIndex extends ConsumerWidget {
  AcademyIndex({
    Key? key,
  }) : super(key: key);

  final TextEditingController searchInput = TextEditingController();

  void unFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Leksykon'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          debugPrint('gesture detector tapped');
          unFocus(context);
        },
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchInput,
                  decoration: InputDecoration(
                      label: const Text('Szukaj'),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: ref.watch(indexSearch).isEmpty
                            ? null
                            : () {
                          searchInput.clear();
                          unFocus(context);
                          ref.read(indexController).searchIndex('');
                        },
                        icon: const Icon(Icons.clear),
                      )),
                  onChanged: (val) {
                    ref.read(indexController).searchIndex(val);
                  },
                ),
              ),
            ),
            const Expanded(
                flex: 7,
                child: IndexEntryList()),
          ],
        ),
      ),

    );
  }
}

class IndexEntryList extends ConsumerWidget {
  const IndexEntryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<IndexEntry> indexList = ref.watch(indexSearchedList);
    return ListView.separated(
      itemCount: indexList.length,
      separatorBuilder: (context, index){
        return const Divider(color: Colors.grey, height: 2.0);
      },
      itemBuilder: (BuildContext context, int index) {
        final entry = indexList[index];
        return ExpansionTile(
          // value: indexList[index].title,
          // canTapOnHeader: true,
          // headerBuilder: (context, isExpanded) => ListTile(title: Text(indexList[index].title, style: const TextStyle(fontSize: 18),)),
          title: Text(entry.title),

          // children: [buildPanelBody(entry)],
          children: [buildPanelBody(indexList[index])]);

      }
      //     ExpansionPanelList.radio(
      //   children: indexList.map((entry) =>
      //       ExpansionPanelRadio(
      //         value: entry.title,
      //           canTapOnHeader: true,
      //           headerBuilder: (context, isExpanded) => ListTile(title: Text(entry.title, style: const TextStyle(fontSize: 18),)),
      //           body: buildPanelBody(entry),
      //       )
      //   ).toList(),
      // ),
    );
  }




  Widget buildPanelBody(IndexEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 25.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ang. ${entry.translation}', style: const TextStyle(fontStyle: FontStyle.italic),),
          const SizedBox(height: 10,),
          Text(entry.description),
        ],
      ),
    );
  }
}

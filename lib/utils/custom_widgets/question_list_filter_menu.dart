// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sepapka/utils/consts/question.dart';
// import 'package:sepapka/viewmanager.dart';
//
//
// Widget buildFilterMenu() {
//   return PopupMenuButton(
//     // child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_list), label: const Text('Filtruj')),
//     icon: const Icon(Icons.filter_list),
//     itemBuilder: (context) => [
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.all),
//         child: const Text('wszystkie'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.shownOnly),
//         child: const Text('tylko nieukryte'),
//       ),
//       PopupMenuItem(
//       onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.notShownOnly),
//         child: const Text('tylko ukryte'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.level1),
//         child: const Text('tylko lvl 1'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.level2),
//         child: const Text('tylko lvl 2'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.level3),
//         child: const Text('tylko lvl 3'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.labelName1),
//         child: const Text('kat. $labelName1'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.labelName2),
//         child: const Text('kat. $labelName2'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.labelName3),
//         child: const Text('kat. $labelName3'),
//       ),
//       PopupMenuItem(
//         onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.labelName4),
//         child: const Text('kat. $labelName4'),
//       ),
//     ],
//   );
//
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


Widget buildFilterMenu() {
  return PopupMenuButton(
    // child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_list), label: const Text('Filtruj')),
    icon: const Icon(Icons.filter_list),
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.alphabetical),
        child: const Text('brak'),
      ),
      PopupMenuItem(
      onTap: () => context.read<Manager>().getFilteredQuestionList(filter: QuestionFilter.allNotShown),
        child: const Text('tylko ukryte'),
      ),
    ],
  );

}
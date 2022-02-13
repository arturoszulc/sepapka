import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/rank_user.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class UserRankScreen extends StatelessWidget {
  const UserRankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RankUser>?>(
        stream: context.read<Manager>().userRankTop,
        builder: (context, snapshot) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.read<Manager>().navigate(Screen.menu),
                ),
                title: const Text('Rank List'),
                centerTitle: true,
                bottom: const TabBar(
                    tabs: [
                      Tab(text: 'top users'),
                      Tab(text: 'your position'),

                    ]),
              ),
              body: TabBarView(
                  children: [
                    buildRank(snapshot),
                    buildRankUser(),
                    const Text('your position'),
              ]
              ),//buildRank(snapshot),
            ),
          );
        }

    );
  }
}

Widget buildRankTop() {
  return
}


Widget buildRank(AsyncSnapshot snapshot) {
  return !snapshot.hasData ?
  const Center(
    child: Text('rank empty'),
  )
      : Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      padding: const EdgeInsets.only(bottom: 70),
      children: snapshot.data.map<Widget>((user) {
        return Card(
          child: ListTile(
            title: Text(user.username),
            subtitle: Text('${user.rankLevel} - ${user.rankTotalPoints}'),
          ),
        );
      }).toList(),
    ),
  );
}

class BuildRank extends StatelessWidget {
  const BuildRank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<RankUser>?>(context);
    return users == null
        ? const Center(
            child: Text('rank empty'),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 70),
              children: users.map((user) {
                return Card(
                  child: ListTile(
                    title: Text(user.username),
                    subtitle: Text('${user.rankLevel} - ${user.rankTotalPoints}'),
                  ),
                );
              }).toList(),
            ),
          );
  }
}

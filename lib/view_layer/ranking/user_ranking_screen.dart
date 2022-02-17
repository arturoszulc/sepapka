import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/rank_user.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class UserRankScreen extends StatelessWidget {
  const UserRankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return WillPopScope(
            onWillPop: () => context.read<Manager>().navigate(Screen.menu),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => context.read<Manager>().navigate(Screen.menu),
                  ),
                  title: const Text('Ranking'),
                  centerTitle: true,
                  bottom: const TabBar(
                    labelColor: Color(0xff383838),
                      tabs: [
                        Tab(text: 'top users'),
                        Tab(text: 'your position'),

                      ]),
                ),
                body: TabBarView(
                    children: [
                      buildRankTop(context),
                      buildRankUser(context),
                ]
                ),//buildRank(snapshot),
              ),
            ),
          );
;
  }
}

Widget buildRankTop(BuildContext context) {
  return StreamBuilder<List<RankUser>?>(
      stream: context.read<Manager>().userRankTop,
      builder: (context, snapshot) {
        return !snapshot.hasData ?
        const Center(
          child: Text('rank empty'),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            padding: const EdgeInsets.only(bottom: 70),
            itemBuilder: (BuildContext context, int index) {
              List<RankUser> userList = snapshot.data!;
              return Card(
                child: ListTile(
                  leading: Image.asset('assets/images/badges/${userList[index].rankLevel}.png',
                  height: 40,),
                  title: Text(userList[index].username),
                  subtitle: Text('Poziom: ${userList[index].rankLevel} - Liczba punktów: ${userList[index].rankTotalPoints}'),
                ),
              );
            },

          ),
        );
      }

  );
}


Widget buildRankUser(BuildContext context) {
  return StreamBuilder<List<RankUser>?>(
      stream: context.read<Manager>().userRankUser,
      builder: (context, snapshot) {
        return !snapshot.hasData ?
        const Center(
          child: Text('rank empty'),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 70),
            children: snapshot.data!.map<Widget>((user) {
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

  );
}


// Widget buildRank(AsyncSnapshot snapshot) {
//   return !snapshot.hasData ?
//   const Center(
//     child: Text('rank empty'),
//   )
//       : Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ListView(
//       padding: const EdgeInsets.only(bottom: 70),
//       children: snapshot.data.map<Widget>((user) {
//         return Card(
//           child: ListTile(
//             title: Text(user.username),
//             subtitle: Text('${user.rankLevel} - ${user.rankTotalPoints}'),
//           ),
//         );
//       }).toList(),
//     ),
//   );
// }
//
// class BuildRank extends StatelessWidget {
//   const BuildRank({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final users = Provider.of<List<RankUser>?>(context);
//     return users == null
//         ? const Center(
//             child: Text('rank empty'),
//           )
//         : Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               padding: const EdgeInsets.only(bottom: 70),
//               children: users.map((user) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(user.username),
//                     subtitle: Text('${user.rankLevel} - ${user.rankTotalPoints}'),
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//   }
// }

import 'package:flutter/material.dart';
import 'package:meu_patrimonio/data/model/goal.dart';
import 'package:meu_patrimonio/data/repository/goal_repository.dart';
import 'package:meu_patrimonio/pages/goals/create_goal_page.dart';
import 'package:meu_patrimonio/widgets/item_summary_card.dart';

import 'goal_detail_page.dart';

class GoalListPage extends StatefulWidget {
  const GoalListPage({Key? key}) : super(key: key);

  @override
  State<GoalListPage> createState() => _GoalListPageState();
}

class _GoalListPageState extends State<GoalListPage> {
  final _repository = GoalRepository();

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Metas")),
      body: FutureBuilder<List<Goal>>(
        future: _repository.getGoals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (snapshot.data != null) {
                    final goal = snapshot.data![index];
                    return ItemSummaryCard(
                      title: goal.name,
                      balance: goal.balance(),
                      rentability: goal.formattedRentability(),
                      onClick: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GoalDetailPage(goal: goal),
                          ),
                        );
                        _update();
                      },
                    );
                  }
                  return const Center();
                },
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateGoalPage(),
            ),
          );
          _update();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

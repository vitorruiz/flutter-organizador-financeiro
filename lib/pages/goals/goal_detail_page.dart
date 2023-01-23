import 'package:flutter/material.dart';
import 'package:meu_patrimonio/data/model/goal.dart';
import 'package:meu_patrimonio/data/model/investment.dart';
import 'package:meu_patrimonio/data/repository/goal_repository.dart';
import 'package:meu_patrimonio/pages/investments/create_investment_page.dart';
import 'package:meu_patrimonio/widgets/item_summary_card.dart';

class GoalDetailPage extends StatefulWidget {
  const GoalDetailPage({Key? key, required this.goal}) : super(key: key);

  @override
  State<GoalDetailPage> createState() => _GoalDetailPageState();

  final Goal goal;
}

class _GoalDetailPageState extends State<GoalDetailPage> {
  final _repository = GoalRepository();

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.goal.name)),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<Investment>>(
          future: _repository.getInvestments(widget.goal.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                padding: const EdgeInsets.all(24.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (snapshot.data != null) {
                      final investment = snapshot.data![index];
                      return ItemSummaryCard(
                        title: investment.name,
                        balance: investment.balance(),
                        rentability: investment.formattedRentability(),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateInvestmentPage(),
            ),
          );
          _update();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

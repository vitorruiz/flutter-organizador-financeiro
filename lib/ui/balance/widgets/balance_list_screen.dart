import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/balance/view_models/balance_viewmodel.dart';
import 'package:meu_patrimonio/ui/balance/widgets/create_balance_screen.dart';
import 'package:meu_patrimonio/ui/widgets/item_summary_card.dart';
import 'package:provider/provider.dart';

class BalanceListScreen extends StatelessWidget {
  const BalanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BalanceViewmodel>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: ListenableBuilder(
          listenable: viewModel.loadAccountBalanceList,
          builder: (context, child) {
            if (viewModel.loadAccountBalanceList.completed && child != null) {
              return child;
            }

            if (viewModel.loadAccountBalanceList.running) {
              return const Center(child: CircularProgressIndicator());
            }

            final accountBalanceList = viewModel.accountBalanceList;

            if (accountBalanceList.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final account = accountBalanceList[index];
                  return ItemSummaryCard(
                    title: account.name,
                    balance: account.balance,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBalanceScreen(account: account)));
                    },
                  );
                },
                itemCount: accountBalanceList.length,
              );
            }

            return const Center(child: Text("Você ainda não possui nenhuma conta"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateBalanceScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

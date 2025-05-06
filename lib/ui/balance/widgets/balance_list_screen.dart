import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/account_balance.dart';
import '../../widgets/item_summary_card.dart';
import '../view_models/balance_viewmodel.dart';
import 'create_balance_screen.dart';

class BalanceListScreen extends StatelessWidget {
  const BalanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BalanceViewmodel viewModel = context.read<BalanceViewmodel>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: ListenableBuilder(
          listenable: viewModel.loadAccountBalanceList,
          builder: (BuildContext context, Widget? child) {
            if (viewModel.loadAccountBalanceList.completed && child != null) {
              return child;
            }

            if (viewModel.loadAccountBalanceList.running) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<AccountBalance> accountBalanceList = viewModel.accountBalanceList;

            if (accountBalanceList.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final AccountBalance account = accountBalanceList[index];
                  return ItemSummaryCard(
                    title: account.name,
                    balance: account.balance,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => CreateBalanceScreen(account: account),
                        ),
                      );
                    },
                  );
                },
                itemCount: accountBalanceList.length,
              );
            }

            return const Center(child: Text('Você ainda não possui nenhuma conta'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (BuildContext context) => const CreateBalanceScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

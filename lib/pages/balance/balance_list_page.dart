import 'package:flutter/material.dart';
import 'package:meu_patrimonio/data/model/account_balance.dart';
import 'package:meu_patrimonio/data/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/pages/balance/create_balance_page.dart';
import 'package:meu_patrimonio/widgets/item_summary_card.dart';

class BalanceListPage extends StatefulWidget {
  const BalanceListPage({Key? key}) : super(key: key);

  @override
  State<BalanceListPage> createState() => _BalanceListPageState();
}

class _BalanceListPageState extends State<BalanceListPage> {
  final _repository = AccountBalanceRepository();

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contas")),
      body: FutureBuilder<List<AccountBalance>>(
        future: _repository.getBalances(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (snapshot.data != null) {
                    final account = snapshot.data![index];
                    return ItemSummaryCard(
                      title: account.name,
                      balance: account.balance,
                      onClick: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateBalancePage(account: account),
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
              builder: (context) => const CreateBalancePage(),
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

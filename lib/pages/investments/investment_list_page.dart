import 'package:flutter/material.dart';
import 'package:meu_patrimonio/data/model/investment.dart';
import 'package:meu_patrimonio/data/repository/investment_repository.dart';
import 'package:meu_patrimonio/pages/investments/create_investment_page.dart';

import '../../widgets/item_summary_card.dart';

class InvestmentListPage extends StatefulWidget {
  const InvestmentListPage({Key? key}) : super(key: key);

  @override
  State<InvestmentListPage> createState() => _InvestmentListPageState();
}

class _InvestmentListPageState extends State<InvestmentListPage> {
  final _repository = InvestmentRepository();

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Investimentos")),
      body: FutureBuilder<List<Investment>>(
        future: _repository.getInvestments(),
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
                      onClick: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateInvestmentPage(investment: investment),
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
              builder: (context) => const CreateInvestmentPage(),
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

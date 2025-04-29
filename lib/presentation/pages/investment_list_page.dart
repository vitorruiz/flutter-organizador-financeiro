import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/presentation/blocs/investment_notifier.dart';
import 'package:meu_patrimonio/presentation/pages/create_investment_page.dart';
import 'package:meu_patrimonio/presentation/widgets/item_summary_card.dart';

class InvestmentListPage extends ConsumerWidget {
  const InvestmentListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investments = ref.watch(investmentListProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: ListView.separated(
          itemCount: investments.length,
          itemBuilder: (context, index) {
            final investment = investments[index];
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
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
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
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ); 
  }
}
import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/investments/view_models/investments_viewmodel.dart';
import 'package:meu_patrimonio/ui/investments/widgets/create_investment_screen.dart';
import 'package:meu_patrimonio/ui/widgets/item_summary_card.dart';
import 'package:provider/provider.dart';

class InvestmentListScreen extends StatelessWidget {
  const InvestmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InvestmentsViewmodel viewModel = context.read<InvestmentsViewmodel>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: ListenableBuilder(
          listenable: viewModel.loadInvestmentList,
          builder: (context, child) {
            if (viewModel.loadInvestmentList.completed && child != null) {
              return child;
            }

            if (viewModel.loadInvestmentList.running) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.investmentList.isNotEmpty) {
              return ListView.separated(
                itemCount: viewModel.investmentList.length,
                itemBuilder: (context, index) {
                  final investment = viewModel.investmentList[index];
                  return ItemSummaryCard(
                    title: investment.name,
                    balance: investment.balance(),
                    rentability: investment.formattedRentability(),
                    onClick: () async {
                      await Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => CreateInvestmentScreen(investment: investment)));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              );
            }

            return const Center(child: Text("Você ainda não possui nenhum investmento"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateInvestmentScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

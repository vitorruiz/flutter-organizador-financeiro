import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/ui/dashboard/view_models/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  // final DashboardViewmodel viewModel;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardViewmodel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = context.read<DashboardViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ListenableBuilder(
              listenable: viewModel.loadTotalBalance,
              builder: (context, child) {
                if (viewModel.loadTotalBalance.completed && child != null) {
                  return child;
                }

                return _cardBalanceResume(context, "Saldo total", viewModel.totalBalance);
              },
            ),
            const SizedBox(height: 16.0),
            ListenableBuilder(
              listenable: viewModel.loadTotalBalance,
              builder: (context, child) {
                if (viewModel.loadTotalBalance.completed && child != null) {
                  return child;
                }

                return _buildInvestmentsCard(context, viewModel.totalInvestmentsDto.balance, viewModel.totalInvestmentsDto.rentability);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _cardBalanceResume(BuildContext context, String title, double balance) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(
              formatToCurrency(balance),
              // MoneyFormatter(amount: balance, settings: moneyFormatterSettings).output.symbolOnLeft,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInvestmentsCard(BuildContext context, double balance, String rentability) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Text('Investimentos', style: Theme.of(context).textTheme.titleLarge),
            Text(balance.toCurrency(), style: Theme.of(context).textTheme.displaySmall),
            Text("Rentabilidade: $rentability", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    ),
  );
}

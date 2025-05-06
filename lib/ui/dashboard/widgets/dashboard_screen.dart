import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions.dart';
import '../../../common/utils.dart';
import '../view_models/dashboard_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

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
          children: <Widget>[
            ListenableBuilder(
              listenable: viewModel.loadTotalBalance,
              builder: (BuildContext context, Widget? child) {
                if (viewModel.loadTotalBalance.completed && child != null) {
                  return child;
                }

                return _cardBalanceResume(context, 'Saldo total', viewModel.totalBalance);
              },
            ),
            const SizedBox(height: 16.0),
            ListenableBuilder(
              listenable: viewModel.loadTotalBalance,
              builder: (BuildContext context, Widget? child) {
                if (viewModel.loadTotalBalance.completed && child != null) {
                  return child;
                }

                return _buildInvestmentsCard(
                  context,
                  viewModel.totalInvestmentsDto.balance,
                  viewModel.totalInvestmentsDto.rentability,
                );
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
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(
              formatToCurrency(balance),
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
          children: <Widget>[
            Text('Investimentos', style: Theme.of(context).textTheme.titleLarge),
            Text(balance.toCurrency(), style: Theme.of(context).textTheme.displaySmall),
            Text('Rentabilidade: $rentability', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    ),
  );
}

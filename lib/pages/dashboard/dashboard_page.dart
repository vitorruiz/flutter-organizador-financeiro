import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/data/dto/total_invesments_dto.dart';
import 'package:meu_patrimonio/data/repository/dashboard_repository.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _repository = DashboardRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patrimonio")),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            FutureBuilder<double>(
              initialData: 0,
              future: _repository.getTotalBalance(),
              builder: (context, snapshot) {
                return _cardBalanceResume(context, "Saldo total", snapshot.requireData);
              },
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<TotalInvestmentsDto>(
              initialData: TotalInvestmentsDto(balance: 0, rentability: ''),
              future: _repository.getInvestmentsTotalData(),
              builder: (context, snapshot) {
                return _buildInvestmentsCard(context, snapshot.requireData.balance, snapshot.requireData.rentability);
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
            )
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

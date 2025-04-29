import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/data/dto/total_invesments_dto.dart';
import 'package:meu_patrimonio/presentation/blocs/dashboard_notifier.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  double _totalBalance = 0;
  TotalInvestmentsDto? _totalInvestmentsDto;

  @override
  void initState() {
    super.initState();

    _totalBalance = ref.read(totalBalanceProvider);
    _totalInvestmentsDto = ref.read(investmentsTotalDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Patrimonio")),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _cardBalanceResume(context, "Saldo total", _totalBalance),
            const SizedBox(height: 16.0),
            _buildInvestmentsCard(context, _totalInvestmentsDto?.balance ?? 0, _totalInvestmentsDto?.rentability ?? "0%"),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../view_models/investments_viewmodel.dart';
import 'create_investment_screen.dart';

class InvestmentListScreen extends StatelessWidget {
  const InvestmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<InvestmentsViewmodel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListenableBuilder(
          listenable: viewModel.loadInvestmentList,
          builder: (context, child) {
            if (viewModel.loadInvestmentList.running) {
              return const Center(child: CircularProgressIndicator());
            }

            final investments = viewModel.investmentList;
            if (investments.isEmpty) {
              return const Center(child: Text('Você ainda não possui nenhum investimento'));
            }

            return ListView.separated(
              itemCount: investments.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final inv = investments[index];
                final rentValue = inv.rentability();
                final isPositive = rentValue >= 0;
                final icon = isPositive ? Icons.trending_up : Icons.trending_down;
                final color = isPositive ? Colors.green : Colors.red;

                final date = DateTime.fromMillisecondsSinceEpoch(inv.updatedAt);
                final formattedTime = DateFormat('dd/MM/y').format(date);

                return InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CreateInvestmentScreen(investment: inv)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(inv.name, style: Theme.of(context).textTheme.titleMedium),
                              if (formattedTime.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  formattedTime,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formatToCurrency(inv.balance()),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(icon, size: 16, color: color),
                                const SizedBox(width: 4),
                                Text(
                                  inv.formattedRentability(),
                                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CreateInvestmentScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

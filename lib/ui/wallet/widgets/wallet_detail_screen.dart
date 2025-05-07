import 'package:flutter/material.dart';

import '../../../common/utils.dart';
import '../../../domain/entities/investment_wallet.dart';

class WalletDetailScreen extends StatelessWidget {
  const WalletDetailScreen({super.key, required this.wallet});

  final InvestmentWallet wallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wallet.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: implementar edição da carteira
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Valor para investir:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              formatToCurrency(wallet.valueToInvest),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text('Opções', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child:
                  wallet.options.isEmpty
                      ? const Center(child: Text('Nenhuma opção cadastrada.'))
                      : ListView.separated(
                        itemCount: wallet.options.length,
                        separatorBuilder: (_, _) => const Divider(),
                        itemBuilder: (context, index) {
                          final option = wallet.options[index];
                          return ListTile(
                            title: Text(option.name),
                            subtitle: Text(formatToCurrency(option.amount())),
                            onTap: () {
                              // TODO: detalhes da opção
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: adicionar nova opção
        },
        tooltip: 'Adicionar opção',
        child: const Icon(Icons.add),
      ),
    );
  }
}

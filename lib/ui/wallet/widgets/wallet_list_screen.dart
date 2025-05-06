import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/investment_wallet.dart';
import '../view_models/wallet_list_viewmodel.dart';

class WalletListScreen extends StatefulWidget {
  const WalletListScreen({super.key});

  @override
  State<WalletListScreen> createState() => _WalletListScreenState();
}

class _WalletListScreenState extends State<WalletListScreen> {
  late WalletListViewmodel _viewModel;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _viewModel = context.read<WalletListViewmodel>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Carteira'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Valor para investir'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _nameController.clear();
                _valueController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text.trim();
                final double value =
                    double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0;
                if (name.isEmpty) {
                  return;
                }

                _viewModel.saveOrUpdateWallet.execute(
                  InvestmentWallet(name: name, valueToInvest: value),
                );

                _nameController.clear();
                _valueController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carteiras de Investimento')),
      body: ListenableBuilder(
        listenable: _viewModel.loadWalletList,
        builder: (BuildContext context, Widget? child) {
          if (_viewModel.loadWalletList.completed && child != null) {
            return child;
          }

          if (_viewModel.loadWalletList.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.walletList.isNotEmpty) {
            return ListView.separated(
              itemCount: _viewModel.walletList.length,
              itemBuilder: (BuildContext context, int index) {
                final InvestmentWallet wallet = _viewModel.walletList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(wallet.name),
                    subtitle: Text(formatToCurrency(wallet.valueToInvest)),
                    onTap: () {
                      // TODO: Navegar para detalhes/opções da carteira
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }

          return const Center(child: Text('Você ainda não possui nenhuma carteira'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

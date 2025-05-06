import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/investment_category.dart';
import '../view_models/investment_category_viewmodel.dart';

class InvestmentCategoryScreen extends StatelessWidget {
  const InvestmentCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InvestmentCategoryViewmodel viewModel = context.read<InvestmentCategoryViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias de Investimentos')),
      body: ListenableBuilder(
        listenable: viewModel.loadInvestmentCategoryList,
        builder: (BuildContext context, Widget? child) {
          return viewModel.investmentCategoryList.isEmpty
              ? const Center(child: Text('Nenhuma categoria cadastrada.'))
              : ListView.builder(
                itemCount: viewModel.investmentCategoryList.length,
                itemBuilder: (BuildContext ctx, int i) {
                  final InvestmentCategory cat = viewModel.investmentCategoryList[i];
                  return ListTile(
                    title: Text(cat.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => viewModel.deleteInvestmentCategory.execute(cat.id),
                    ),
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showCreateDialog(context, viewModel),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, InvestmentCategoryViewmodel viewModel) {
    final TextEditingController txtCtrl = TextEditingController();
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Nova Categoria'),
            content: TextField(
              controller: txtCtrl,
              decoration: const InputDecoration(labelText: 'Nome da categoria'),
            ),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  final String name = txtCtrl.text.trim();
                  if (name.isNotEmpty) {
                    viewModel.createInvestmentCategory.execute(InvestmentCategory(name: name));
                  }
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }
}

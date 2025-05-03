import 'package:flutter/material.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/ui/investment_category/view_models/investment_category_viewmodel.dart';
import 'package:provider/provider.dart';

class InvestmentCategoryScreen extends StatelessWidget {
  const InvestmentCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<InvestmentCategoryViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias de Investimentos')),
      body: ListenableBuilder(
        listenable: viewModel.loadInvestmentCategoryList,
        builder: (context, child) {
          return viewModel.investmentCategoryList.isEmpty
              ? const Center(child: Text('Nenhuma categoria cadastrada.'))
              : ListView.builder(
                itemCount: viewModel.investmentCategoryList.length,
                itemBuilder: (ctx, i) {
                  final cat = viewModel.investmentCategoryList[i];
                  return ListTile(
                    title: Text(cat.name),
                    trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => viewModel.deleteInvestmentCategory.execute(cat.id)),
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () => _showCreateDialog(context, viewModel)),
    );
  }

  void _showCreateDialog(BuildContext context, InvestmentCategoryViewmodel viewModel) {
    final txtCtrl = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Nova Categoria'),
            content: TextField(controller: txtCtrl, decoration: const InputDecoration(labelText: 'Nome da categoria')),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  final name = txtCtrl.text.trim();
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

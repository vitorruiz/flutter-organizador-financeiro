import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/investment_category/widgets/investment_category_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorias de Investimentos'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentCategoryScreen()));
            },
          ),
        ],
      ),
    );
  }
}

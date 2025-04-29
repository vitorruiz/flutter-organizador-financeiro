import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meu_patrimonio/data/local/model/account_balance_model.dart';
import 'package:meu_patrimonio/data/local/model/investment_model.dart';
import 'package:meu_patrimonio/presentation/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive para armazenamento local
  await Hive.initFlutter();

  // Register adapters Hive
  Hive.registerAdapter(InvestmentModelAdapter());
  Hive.registerAdapter(AccountBalanceModelAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}

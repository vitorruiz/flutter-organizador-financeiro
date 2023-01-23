import 'package:flutter/material.dart';
import 'package:meu_patrimonio/pages/balance/balance_list_page.dart';
import 'package:meu_patrimonio/pages/dashboard/dashboard_page.dart';
import 'package:meu_patrimonio/pages/investments/investment_list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: "Patrimonio"),
          NavigationDestination(icon: Icon(Icons.account_balance_outlined), label: "Investimentos"),
          NavigationDestination(icon: Icon(Icons.bookmark_border_outlined), label: "Contas"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: [
        const DashboardPage(),
        const InvestmentListPage(),
        const BalanceListPage(),
      ][currentPageIndex],
    );
  }
}

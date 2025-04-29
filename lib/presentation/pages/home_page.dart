import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/presentation/pages/balance_list_page.dart';
import 'package:meu_patrimonio/presentation/pages/dashboard_page.dart';
import 'package:meu_patrimonio/presentation/pages/investment_list_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    DashboardPage(),
    InvestmentListPage(),
    BalanceListPage(),
  ];

  static const _titles = <String>['Dashboard', 'Investimentos', 'Contas'];

  static const _navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Investimentos'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Contas'),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (_) => const ConfigurationPage()),
          //   ),
          // ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: _navItems, currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/balance/widgets/balance_list_screen.dart';
import 'package:meu_patrimonio/ui/dashboard/widgets/dashboard_screen.dart';
import 'package:meu_patrimonio/ui/investments/widgets/investment_list_page.dart';
import 'package:meu_patrimonio/ui/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[DashboardScreen(), InvestmentListScreen(), BalanceListScreen()];

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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: _navItems, currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

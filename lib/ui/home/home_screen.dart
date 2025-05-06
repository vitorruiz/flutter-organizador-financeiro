import 'package:flutter/material.dart';
import '../balance/widgets/balance_list_screen.dart';
import '../dashboard/widgets/dashboard_screen.dart';
import '../investments/widgets/investment_list_page.dart';
import '../settings/settings_screen.dart';
import '../wallet/widgets/wallet_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenSelected _selectedScreen = ScreenSelected.dashboard;

  void _onScreenSelected(ScreenSelected screen) {
    setState(() => _selectedScreen = screen);
    Navigator.pop(context);
  }

  Widget _pageByScreen(ScreenSelected screen) {
    switch (screen) {
      case ScreenSelected.dashboard:
        return const DashboardScreen();
      case ScreenSelected.accounts:
        return const BalanceListScreen();
      case ScreenSelected.investments:
        return const InvestmentListScreen();
      case ScreenSelected.wallets:
        return const WalletListScreen();
    }
  }

  String _titleByScreen(ScreenSelected screen) {
    switch (screen) {
      case ScreenSelected.dashboard:
        return 'Dashboard';
      case ScreenSelected.accounts:
        return 'Contas';
      case ScreenSelected.investments:
        return 'Investimentos';
      case ScreenSelected.wallets:
        return 'Carteiras';
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleByScreen(_selectedScreen)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                _onScreenSelected(ScreenSelected.dashboard);
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text('Carteiras'),
              onTap: () {
                _onScreenSelected(ScreenSelected.wallets);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Contas'),
              onTap: () {
                _onScreenSelected(ScreenSelected.accounts);
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Investimentos'),
              onTap: () {
                _onScreenSelected(ScreenSelected.investments);
              },
            ),
          ],
        ),
      ),
      body: _pageByScreen(_selectedScreen),
    );
  }
}

enum ScreenSelected {
  dashboard,
  accounts,
  investments,
  wallets,
}

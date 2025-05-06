import 'investment.dart';
import 'investment_wallet.dart';

class InvestmentWalletOption {

  InvestmentWalletOption({
    int? id,
    required this.name,
    required this.walletPercentage,
    required this.value,
    required this.wallet,
    this.investment,
  }) : id = id ?? 0;
  int id;
  String name;
  double walletPercentage;
  double value;
  InvestmentWallet wallet;
  Investment? investment;

  double amount() {
    return investment?.amount() ?? 0;
  }

  double balance() {
    return investment?.balance() ?? 0;
  }

  double rentability() {
    return investment?.rentability() ?? 0;
  }

  String formattedRentability() {
    return investment?.formattedRentability() ?? '';
  }
}

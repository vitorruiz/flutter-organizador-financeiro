import 'investment_wallet_option.dart';

class InvestmentWallet {

  InvestmentWallet({int? id, required this.name, required this.valueToInvest}) : id = id ?? 0;
  int id;
  String name;
  double valueToInvest;
  List<InvestmentWalletOption> options = <InvestmentWalletOption>[];
}

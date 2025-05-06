import '../entities/investment_wallet_option.dart';

abstract class InvestmentWalletOptionRepository {
  Future<List<InvestmentWalletOption>> getAll();
  Future<int> create(InvestmentWalletOption investmentWalletOption);
  Future<bool> remove(int id);
}

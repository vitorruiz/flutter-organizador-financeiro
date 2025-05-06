import '../entities/investment_wallet.dart';

abstract class InvestmentWalletRepository {
  Future<List<InvestmentWallet>> getAll();
  Future<int> create(InvestmentWallet investmentWallet);
  Future<bool> remove(int id);
}

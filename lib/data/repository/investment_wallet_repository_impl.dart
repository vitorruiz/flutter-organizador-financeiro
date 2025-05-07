import '../../domain/entities/investment_wallet.dart';
import '../../domain/entities/investment_wallet_option.dart';
import '../../domain/repository/investment_wallet_repository.dart';
import '../../main.dart';
import '../../objectbox.g.dart';
import '../local/model/investment_wallet_model.dart';

class InvestmentWalletRepositoryImpl implements InvestmentWalletRepository {
  final Box<InvestmentWalletModel> _box = objectbox.store.box<InvestmentWalletModel>();

  @override
  Future<int> create(InvestmentWallet investmentWallet) async {
    final options = [
      InvestmentWalletOption(
        name: 'Renda Fixa Pós',
        walletPercentage: 15,
        value: investmentWallet.valueToInvest * (15 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'Renda Fixa Dinamica',
        walletPercentage: 20,
        value: investmentWallet.valueToInvest * (20 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'FIIs',
        walletPercentage: 15,
        value: investmentWallet.valueToInvest * (15 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'Ações',
        walletPercentage: 15,
        value: investmentWallet.valueToInvest * (15 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'Internacional',
        walletPercentage: 20,
        value: investmentWallet.valueToInvest * (20 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'Fundos Multimercado',
        walletPercentage: 12,
        value: investmentWallet.valueToInvest * (12 / 100),
        // wallet: investmentWallet,
      ),
      InvestmentWalletOption(
        name: 'Alternativos',
        walletPercentage: 3,
        value: investmentWallet.valueToInvest * (3 / 100),
        // wallet: investmentWallet,
      ),
    ];
    investmentWallet.options = options;
    return _box.put(InvestmentWalletModel.fromDomain(investmentWallet));
  }

  @override
  Future<List<InvestmentWallet>> getAll() async {
    return _box.getAll().map((InvestmentWalletModel m) => m.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

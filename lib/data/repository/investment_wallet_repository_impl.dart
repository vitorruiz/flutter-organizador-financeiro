import '../../domain/entities/investment_wallet.dart';
import '../../domain/repository/investment_wallet_repository.dart';
import '../../main.dart';
import '../../objectbox.g.dart';
import '../local/model/investment_wallet_model.dart';

class InvestmentWalletRepositoryImpl implements InvestmentWalletRepository {
  final Box<InvestmentWalletModel> _box = objectbox.store.box<InvestmentWalletModel>();

  @override
  Future<int> create(InvestmentWallet investmentWallet) async {
    return _box.put(InvestmentWalletModel.fromDomain(investmentWallet));
  }

  @override
  Future<List<InvestmentWallet>> getAll() async{
    return _box.getAll().map((InvestmentWalletModel m) => m.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async{
    return _box.remove(id);
  }
}

import 'package:meu_patrimonio/data/local/model/account_balance_model.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:meu_patrimonio/domain/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/main.dart';

class AccountBalanceRepositoryImpl implements AccountBalanceRepository {
  final _box = objectbox.store.box<AccountBalanceModel>();

  @override
  Future<int> create(AccountBalance account) async {
    return _box.put(AccountBalanceModel.fromDomain(account));
  }

  @override
  Future<List<AccountBalance>> getAll() async {
    return _box.getAll().map((model) => model.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

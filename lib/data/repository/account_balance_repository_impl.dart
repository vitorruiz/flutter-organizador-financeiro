import 'package:hive/hive.dart';
import 'package:meu_patrimonio/data/local/model/account_balance_model.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:meu_patrimonio/domain/repository/account_balance_repository.dart';

class AccountBalanceRepositoryImpl implements AccountBalanceRepository {
static const _box = "accounts_balance";

  Future<Box<AccountBalanceModel>> _accounts() async => Hive.openBox<AccountBalanceModel>(_box);

  @override
  Future<void> create(AccountBalance account) async {
    final box = await _accounts();
    return box.put(account.id, AccountBalanceModel.fromDomain(account));
  }

  @override
  Future<List<AccountBalance>> getAll() async {
    final box = await _accounts();
    return box.values.map((model) => model.toDomain()).toList();
  }

  @override
  Future<void> remove(String id) async {
    final box = await _accounts();
    return box.delete(id);
  }
}
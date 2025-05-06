import 'package:objectbox/src/native/box.dart';

import '../../domain/entities/account_balance.dart';
import '../../domain/repository/account_balance_repository.dart';
import '../../main.dart';
import '../local/model/account_balance_model.dart';

class AccountBalanceRepositoryImpl implements AccountBalanceRepository {
  final Box<AccountBalanceModel> _box = objectbox.store.box<AccountBalanceModel>();

  @override
  Future<int> create(AccountBalance account) async {
    return _box.put(AccountBalanceModel.fromDomain(account));
  }

  @override
  Future<List<AccountBalance>> getAll() async {
    return _box.getAll().map((AccountBalanceModel model) => model.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

import '../entities/account_balance.dart';

abstract class AccountBalanceRepository {
  Future<int> create(AccountBalance account);
  Future<bool> remove(int id);
  Future<List<AccountBalance>> getAll();
}

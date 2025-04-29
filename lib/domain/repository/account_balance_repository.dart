import 'package:meu_patrimonio/domain/entities/account_balance.dart';

abstract class AccountBalanceRepository {
  Future<void> create(AccountBalance account);
  Future<void> remove(String id);
  Future<List<AccountBalance>> getAll();
}

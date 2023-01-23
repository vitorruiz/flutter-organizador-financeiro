import 'package:meu_patrimonio/data/db/dao/account_balance_dao.dart';
import 'package:meu_patrimonio/data/model/account_balance.dart';

class AccountBalanceRepository {
  final _accountBalanceDao = AccountBalanceDao();

  Future<List<AccountBalance>> getBalances() {
    return _accountBalanceDao.findAll();
  }

  Future<int> createBalance(String name, double balance) async {
    return _accountBalanceDao.save(AccountBalance(name: name, balance: balance));
  }

  Future<int> editBalance(String id, double balance) async {
    final account = await _accountBalanceDao.find(id);
    account.balance = balance;
    return _accountBalanceDao.save(account);
  }

  Future<int> delete(String id) async {
    return _accountBalanceDao.delete(id);
  }
}

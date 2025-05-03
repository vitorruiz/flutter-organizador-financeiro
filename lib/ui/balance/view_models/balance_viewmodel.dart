import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:meu_patrimonio/domain/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/utils/command.dart';
import 'package:meu_patrimonio/utils/result.dart';

class BalanceViewmodel extends ChangeNotifier {
  BalanceViewmodel({required AccountBalanceRepository accountBalanceRepository}) : _accountBalanceRepository = accountBalanceRepository {
    loadAccountBalanceList = Command0(_loadAccountBalanceList)..execute();
    deleteAccountBalance = Command1(_deleteAccountBalance);
    saveOrUpdateAccountBalance = Command1(_saveOrUpdateAccountBalance);
  }

  final _log = Logger('BalanceViewmodel');

  final AccountBalanceRepository _accountBalanceRepository;

  List<AccountBalance> _accountBalanceList = [];
  List<AccountBalance> get accountBalanceList => _accountBalanceList;

  late final Command0 loadAccountBalanceList;
  late final Command1<void, int> deleteAccountBalance;
  late final Command1<void, AccountBalance> saveOrUpdateAccountBalance;

  Future<Result<void>> _loadAccountBalanceList() async {
    try {
      final result = Result.ok(await _accountBalanceRepository.getAll());
      switch (result) {
        case Error():
          _log.warning('Failed to load stored AccountBalance', result.error);
          return result;
        case Ok():
      }
      _accountBalanceList = result.value;
      _log.info('AccountBalance loaded successfully: $_accountBalanceList');

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteAccountBalance(int id) async {
    try {
      final result = Result.ok(await _accountBalanceRepository.remove(id));
      switch (result) {
        case Error():
          _log.warning('Failed to delete AccountBalance', result.error);
          return result;
        case Ok():
      }
      _log.info('AccountBalance deleted successfully: $id');

      return result;
    } finally {
      notifyListeners();
      loadAccountBalanceList.execute();
    }
  }

  Future<Result<void>> _saveOrUpdateAccountBalance(AccountBalance account) async {
    try {
      final result = Result.ok(await _accountBalanceRepository.create(account));
      switch (result) {
        case Error():
          _log.warning('Failed to save or update AccountBalance', result.error);
          return result;
        case Ok():
      }
      _log.info('AccountBalance saved or updated successfully: $account');

      return result;
    } finally {
      notifyListeners();
      loadAccountBalanceList.execute();
    }
  }
}

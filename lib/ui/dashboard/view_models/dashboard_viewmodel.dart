import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:meu_patrimonio/data/dto/total_invesments_dto.dart';
import 'package:meu_patrimonio/domain/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/domain/repository/investment_repository.dart';
import 'package:meu_patrimonio/utils/command.dart';
import 'package:meu_patrimonio/utils/result.dart';

class DashboardViewmodel extends ChangeNotifier {
  DashboardViewmodel({required AccountBalanceRepository accountBalanceRepository, required InvestmentRepository investmentRepository})
    : _accountBalanceRepository = accountBalanceRepository,
      _investmentRepository = investmentRepository {
    loadTotalBalance = Command0(_loadTotalBalance)..execute();
    loadTotalInvestmentsData = Command0(_loadTotalInvestmentsData)..execute();
  }

  final _log = Logger('DashboardViewmodel');

  final AccountBalanceRepository _accountBalanceRepository;
  final InvestmentRepository _investmentRepository;

  double _totalBalance = 0.0;
  double get totalBalance => _totalBalance;

  TotalInvestmentsDto _totalInvestmentsDto = TotalInvestmentsDto(balance: 0.0, rentability: "0%");
  TotalInvestmentsDto get totalInvestmentsDto => _totalInvestmentsDto;

  late final Command0 loadTotalBalance;
  late final Command0 loadTotalInvestmentsData;

  Future<Result<void>> _loadTotalBalance() async {
    try {
      final resultAccounts = Result.ok(await _accountBalanceRepository.getAll());
      switch (resultAccounts) {
        case Error():
          _log.warning('Failed to load stored ItineraryConfig', resultAccounts.error);
          return resultAccounts;
        case Ok():
      }

      final resultInvestments = Result.ok(await _investmentRepository.getAll());
      switch (resultInvestments) {
        case Error():
          _log.warning('Failed to load stored ItineraryConfig', resultInvestments.error);
          return resultInvestments;
        case Ok():
      }

      _totalBalance = resultAccounts.value.fold(0.0, (previousValue, element) => previousValue + element.balance)
      + resultInvestments.value.fold(0.0, (previousValue, element) => previousValue + element.balance());

      final result = Result.ok(_totalBalance);
      _log.info('Total balance loaded successfully: $_totalBalance');

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _loadTotalInvestmentsData() async {
    try {
      final result = Result.ok(await _investmentRepository.getAll());
      switch (result) {
        case Error():
          _log.warning('Failed to load stored ItineraryConfig', result.error);
          return result;
        case Ok():
      }

      double totalBalance = result.value.fold(0.0, (previousValue, element) => previousValue + element.balance());
      double totalAmount = result.value.fold(0.0, (previousValue, element) => previousValue + element.amount());

      double rentability = (totalBalance / totalAmount) - 1;

      _totalInvestmentsDto = TotalInvestmentsDto(
        balance: totalBalance,
        rentability: "${(rentability * 100).toStringAsFixed(2)}%",
      );

      return result;
    } finally {
      notifyListeners();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/domain/repository/investment_category_repository.dart';
import 'package:meu_patrimonio/domain/repository/investment_repository.dart';
import 'package:meu_patrimonio/utils/command.dart';
import 'package:meu_patrimonio/utils/result.dart';

class InvestmentsViewmodel extends ChangeNotifier {
  InvestmentsViewmodel({required InvestmentCategoryRepository investmentCategoryRepository, required InvestmentRepository investmentRepository})
    : _investmentCategoryRepository = investmentCategoryRepository,
      _investmentRepository = investmentRepository {
    loadInvestmentCategoryList = Command0(_loadInvestmentCategoryList)..execute();
    loadInvestmentList = Command0(_loadInvestmentList)..execute();
    deleteInvestment = Command1(_deleteInvestment);
    saveOrUpdateInvestment = Command1(_saveOrUpdateInvestment);
  }

  final _log = Logger('InvestmentsViewmodel');

  final InvestmentCategoryRepository _investmentCategoryRepository;
  final InvestmentRepository _investmentRepository;

  List<InvestmentCategory> _investmentCategoryList = [];
  List<InvestmentCategory> get investmentCategoryList => _investmentCategoryList;

  List<Investment> _investmentList = [];
  List<Investment> get investmentList => _investmentList;

  late final Command0 loadInvestmentCategoryList;
  late final Command0 loadInvestmentList;
  late final Command1<void, int> deleteInvestment;
  late final Command1<void, Investment> saveOrUpdateInvestment;

  Future<Result<void>> _loadInvestmentCategoryList() async {
    try {
      final result = Result.ok(await _investmentCategoryRepository.getAll());
      switch (result) {
        case Error():
          _log.warning('Failed to load stored InvestmentCategory', result.error);
          return result;
        case Ok():
      }
      _investmentCategoryList = result.value;
      _log.info('InvestmentCategory loaded successfully: $_investmentCategoryList');

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _loadInvestmentList() async {
    try {
      final result = Result.ok(await _investmentRepository.getAll());
      switch (result) {
        case Error():
          _log.warning('Failed to load stored Investment', result.error);
          return result;
        case Ok():
      }
      _investmentList = result.value;
      _log.info('Investment loaded successfully: $_investmentList');

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteInvestment(int id) async {
    try {
      final result = Result.ok(await _investmentRepository.remove(id));
      switch (result) {
        case Error():
          _log.warning('Failed to delete Investment', result.error);
          return result;
        case Ok():
      }
      _log.info('Investment deleted successfully: $id');

      return result;
    } finally {
      notifyListeners();
      loadInvestmentList.execute();
    }
  }

  Future<Result<void>> _saveOrUpdateInvestment(Investment investment) async {
    try {
      final result = Result.ok(await _investmentRepository.create(investment));
      switch (result) {
        case Error():
          _log.warning('Failed to save or update Investment', result.error);
          return result;
        case Ok():
      }
      _log.info('Investment saved or updated successfully: $investment');

      return result;
    } finally {
      notifyListeners();
      loadInvestmentList.execute();
    }
  }
}

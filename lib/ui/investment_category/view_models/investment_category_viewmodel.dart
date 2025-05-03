import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/domain/repository/investment_category_repository.dart';
import 'package:meu_patrimonio/utils/command.dart';
import 'package:meu_patrimonio/utils/result.dart';

class InvestmentCategoryViewmodel extends ChangeNotifier {
  InvestmentCategoryViewmodel({required InvestmentCategoryRepository investmentCategoryRepository})
    : _investmentCategoryRepository = investmentCategoryRepository {
    loadInvestmentCategoryList = Command0(_loadInvestmentCategoryList)..execute();
    deleteInvestmentCategory = Command1(_deleteInvestmentCategory);
    createInvestmentCategory = Command1(_createInvestmentCategory);
  }

  final _log = Logger('InvestmentCategoryViewmodel');

  final InvestmentCategoryRepository _investmentCategoryRepository;

  List<InvestmentCategory> _investmentCategoryList = [];
  List<InvestmentCategory> get investmentCategoryList => _investmentCategoryList;

  late final Command0 loadInvestmentCategoryList;
  late final Command1<void, int> deleteInvestmentCategory;
  late final Command1<void, InvestmentCategory> createInvestmentCategory;

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

  Future<Result<void>> _deleteInvestmentCategory(int id) async {
    try {
      final result = Result.ok(await _investmentCategoryRepository.remove(id));
      switch (result) {
        case Error():
          _log.warning('Failed to delete InvestmentCategory', result.error);
          return result;
        case Ok():
      }
      _log.info('InvestmentCategory deleted successfully: $id');

      return result;
    } finally {
      notifyListeners();
      loadInvestmentCategoryList.execute();
    }
  }

  Future<Result<void>> _createInvestmentCategory(InvestmentCategory category) async {
    try {
      final result = Result.ok(await _investmentCategoryRepository.create(category));
      switch (result) {
        case Error():
          _log.warning('Failed to save InvestmentCategory', result.error);
          return result;
        case Ok():
      }
      _log.info('InvestmentCategory saved successfully: $category');

      return result;
    } finally {
      notifyListeners();
      loadInvestmentCategoryList.execute();
    }
  }
}

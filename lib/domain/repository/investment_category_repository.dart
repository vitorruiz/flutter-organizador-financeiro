import '../entities/investment_category.dart';

abstract class InvestmentCategoryRepository {
  Future<List<InvestmentCategory>> getAll();
  Future<int> create(InvestmentCategory category);
  Future<bool> remove(int id);
}

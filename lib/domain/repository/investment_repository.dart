import '../entities/investment.dart';

abstract class InvestmentRepository {
  Future<int> create(Investment investment);
  Future<bool> remove(int id);
  Future<List<Investment>> getAll();
}

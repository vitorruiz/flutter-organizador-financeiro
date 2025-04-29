import 'package:meu_patrimonio/domain/entities/investment.dart';

abstract class InvestmentRepository {
  Future<void> create(Investment investment);
  Future<void> remove(String id);
  Future<List<Investment>> getAll();
}

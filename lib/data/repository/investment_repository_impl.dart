import 'package:hive/hive.dart';
import 'package:meu_patrimonio/data/local/model/investment_model.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/domain/repository/investment_repository.dart';

class InvestmentRepositoryImpl implements InvestmentRepository {
  static const _box = "investments";

  Future<Box<InvestmentModel>> _investments() async => Hive.openBox<InvestmentModel>(_box);

  @override
  Future<void> create(Investment investment) async {
    final box = await _investments();
    return box.put(investment.id, InvestmentModel.fromDomain(investment));
  }

  @override
  Future<List<Investment>> getAll() async {
    final box = await _investments();
    return box.values.map((model) => model.toDomain()).toList();
  }

  @override
  Future<void> remove(String id) async {
    final box = await _investments();
    return box.delete(id);
  }
}

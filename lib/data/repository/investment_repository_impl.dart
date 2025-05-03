import 'package:meu_patrimonio/data/local/model/investment_model.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/domain/repository/investment_repository.dart';
import 'package:meu_patrimonio/main.dart';

class InvestmentRepositoryImpl implements InvestmentRepository {
  final _box = objectbox.store.box<InvestmentModel>();

  @override
  Future<int> create(Investment investment) async {
    return _box.put(InvestmentModel.fromDomain(investment));
  }

  @override
  Future<List<Investment>> getAll() async {
    return _box.getAll().map((model) {
      final category = model.category.target?.toDomain() ?? InvestmentCategory(name: 'Sem categoria');
      return model.toDomain(category);
    }).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

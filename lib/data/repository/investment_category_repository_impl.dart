import 'package:meu_patrimonio/data/local/model/investment_category_model.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/domain/repository/investment_category_repository.dart';
import 'package:meu_patrimonio/main.dart';

class InvestmentCategoryRepositoryImpl implements InvestmentCategoryRepository {
  final _box = objectbox.store.box<InvestmentCategoryModel>();

  @override
  Future<int> create(InvestmentCategory category) async {
    return _box.put(InvestmentCategoryModel.fromDomain(category));
  }

  @override
  Future<List<InvestmentCategory>> getAll() async {
    return _box.getAll().map((m) => m.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

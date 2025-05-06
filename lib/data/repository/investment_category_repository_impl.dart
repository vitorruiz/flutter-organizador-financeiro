import 'package:objectbox/src/native/box.dart';

import '../../domain/entities/investment_category.dart';
import '../../domain/repository/investment_category_repository.dart';
import '../../main.dart';
import '../local/model/investment_category_model.dart';

class InvestmentCategoryRepositoryImpl implements InvestmentCategoryRepository {
  final Box<InvestmentCategoryModel> _box = objectbox.store.box<InvestmentCategoryModel>();

  @override
  Future<int> create(InvestmentCategory category) async {
    return _box.put(InvestmentCategoryModel.fromDomain(category));
  }

  @override
  Future<List<InvestmentCategory>> getAll() async {
    return _box.getAll().map((InvestmentCategoryModel m) => m.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

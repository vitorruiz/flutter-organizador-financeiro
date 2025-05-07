import 'package:objectbox/src/native/box.dart';

import '../../domain/entities/investment.dart';
import '../../domain/repository/investment_repository.dart';
import '../../main.dart';
import '../local/model/investment_model.dart';

class InvestmentRepositoryImpl implements InvestmentRepository {
  final Box<InvestmentModel> _box = objectbox.store.box<InvestmentModel>();

  @override
  Future<int> create(Investment investment) async {
    investment.updatedAt = DateTime.now().millisecondsSinceEpoch;
    return _box.put(InvestmentModel.fromDomain(investment));
  }

  @override
  Future<List<Investment>> getAll() async {
    return _box.getAll().map((InvestmentModel m) => m.toDomain()).toList();
  }

  @override
  Future<bool> remove(int id) async {
    return _box.remove(id);
  }
}

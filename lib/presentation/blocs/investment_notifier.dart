import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/data/repository/investment_repository_impl.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';

final investmentRepoProvider = Provider((ref) => InvestmentRepositoryImpl());

final investmentListProvider = StateNotifierProvider<InvestmentNotifier, List<Investment>>((ref) => InvestmentNotifier(ref));

class InvestmentNotifier extends StateNotifier<List<Investment>> {
  final Ref ref;

  InvestmentNotifier(this.ref) : super([]) {
    load();
  }

  Future<void> load() async {
    state = await ref.read(investmentRepoProvider).getAll();
  }

  Future<void> saveOrUpdate(Investment investment) async {
    await ref.read(investmentRepoProvider).create(investment);
    await load();
  }

  Future<void> delete(String id) async {
    await ref.read(investmentRepoProvider).remove(id);
    await load();
  }
}

final totalInvestmentsProvider = Provider<double>((ref) {
  final list = ref.watch(investmentListProvider);
  return list.fold(0.0, (sum, e) => sum + e.balance());
});

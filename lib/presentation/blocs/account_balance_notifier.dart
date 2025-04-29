import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/data/repository/account_balance_repository_impl.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';

final accountBalanceRepoProvider = Provider((ref) => AccountBalanceRepositoryImpl());

final accountBalanceListProvider = StateNotifierProvider<AccountBalanceNotifier, List<AccountBalance>>((ref) => AccountBalanceNotifier(ref));

class AccountBalanceNotifier extends StateNotifier<List<AccountBalance>> {
  final Ref ref;

  AccountBalanceNotifier(this.ref) : super([]) {
    load();
  }

  Future<void> load() async {
    state = await ref.read(accountBalanceRepoProvider).getAll();
  }

  Future<void> saveOrUpdate(AccountBalance account) async {
    await ref.read(accountBalanceRepoProvider).create(account);
    await load();
  }

  Future<void> delete(String id) async {
    await ref.read(accountBalanceRepoProvider).remove(id);
    await load();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/data/dto/total_invesments_dto.dart';
import 'package:meu_patrimonio/presentation/blocs/account_balance_notifier.dart';
import 'package:meu_patrimonio/presentation/blocs/investment_notifier.dart';

final totalBalanceProvider = Provider<double>((ref) {
  final accountBalanceTotal = ref.watch(accountBalanceListProvider).fold(0.0, (sum, e) => sum + e.balance);
  final investmentTotal = ref.watch(investmentListProvider).fold(0.0, (sum, e) => sum + e.balance());
  return accountBalanceTotal + investmentTotal;
});

final investmentsTotalDataProvider = Provider<TotalInvestmentsDto>((ref) {
  final investmentList = ref.watch(investmentListProvider);

  double totalBalance = investmentList.fold(0.0, (sum, e) => sum + e.balance());
  double totalAmount = investmentList.fold(0.0, (sum, e) => sum + e.amount());

  double rentability = (totalBalance / totalAmount) - 1;

  return TotalInvestmentsDto(balance: totalBalance, rentability: "${(rentability * 100).toStringAsFixed(2)}%");
});

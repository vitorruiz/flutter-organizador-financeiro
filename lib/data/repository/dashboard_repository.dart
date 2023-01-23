import 'package:meu_patrimonio/data/db/dao/account_balance_dao.dart';
import 'package:meu_patrimonio/data/db/dao/investment_dao.dart';
import 'package:meu_patrimonio/data/dto/total_invesments_dto.dart';

class DashboardRepository {
  final _investmentDao = InvestmentDao();
  final _accountBalanceDao = AccountBalanceDao();

  Future<double> getTotalBalance() async {
    double totalBalance = 0;

    final accounts = await _accountBalanceDao.findAll();
    final investments = await _investmentDao.findAll();

    for (var element in accounts) {
      totalBalance += element.balance;
    }

    for (var element in investments) {
      totalBalance += element.balance();
    }

    return totalBalance;
  }

  Future<TotalInvestmentsDto> getInvestmentsTotalData() async {
    double totalBalance = 0;
    double totalAmount = 0;

    final investments = await _investmentDao.findAll();

    for (var element in investments) {
      totalBalance += element.balance();
      totalAmount += element.amount();
    }

    double rentability = (totalBalance / totalAmount) - 1;

    return TotalInvestmentsDto(balance: totalBalance, rentability: "${(rentability * 100).toStringAsFixed(2)}%");
  }
}

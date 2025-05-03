import 'package:meu_patrimonio/data/repository/account_balance_repository_impl.dart';
import 'package:meu_patrimonio/data/repository/investment_category_repository_impl.dart';
import 'package:meu_patrimonio/data/repository/investment_repository_impl.dart';
import 'package:meu_patrimonio/domain/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/domain/repository/investment_category_repository.dart';
import 'package:meu_patrimonio/domain/repository/investment_repository.dart';
import 'package:meu_patrimonio/ui/balance/view_models/balance_viewmodel.dart';
import 'package:meu_patrimonio/ui/dashboard/view_models/dashboard_viewmodel.dart';
import 'package:meu_patrimonio/ui/investment_category/view_models/investment_category_viewmodel.dart';
import 'package:meu_patrimonio/ui/investments/view_models/investments_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    // Repositories
    Provider<InvestmentRepository>(create: (context) => InvestmentRepositoryImpl()),
    Provider<AccountBalanceRepository>(create: (context) => AccountBalanceRepositoryImpl()),
    Provider<InvestmentCategoryRepository>(create: (context) => InvestmentCategoryRepositoryImpl()),

    // ViewModels
    ChangeNotifierProvider<InvestmentsViewmodel>(
      create:
          (context) => InvestmentsViewmodel(
            investmentCategoryRepository: context.read<InvestmentCategoryRepository>(),
            investmentRepository: context.read<InvestmentRepository>(),
          ),
    ),
    ChangeNotifierProvider<BalanceViewmodel>(create: (context) => BalanceViewmodel(accountBalanceRepository: context.read<AccountBalanceRepository>())),
    ChangeNotifierProvider<DashboardViewmodel>(
      create:
          (context) => DashboardViewmodel(
            investmentRepository: context.read<InvestmentRepository>(),
            accountBalanceRepository: context.read<AccountBalanceRepository>(),
          ),
    ),
    ChangeNotifierProvider<InvestmentCategoryViewmodel>(
      create: (context) => InvestmentCategoryViewmodel(investmentCategoryRepository: context.read<InvestmentCategoryRepository>()),
    ),
  ];
}

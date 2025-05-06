import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repository/account_balance_repository_impl.dart';
import '../data/repository/investment_category_repository_impl.dart';
import '../data/repository/investment_repository_impl.dart';
import '../data/repository/investment_wallet_repository_impl.dart';
import '../domain/repository/account_balance_repository.dart';
import '../domain/repository/investment_category_repository.dart';
import '../domain/repository/investment_repository.dart';
import '../domain/repository/investment_wallet_repository.dart';
import '../ui/balance/view_models/balance_viewmodel.dart';
import '../ui/dashboard/view_models/dashboard_viewmodel.dart';
import '../ui/investment_category/view_models/investment_category_viewmodel.dart';
import '../ui/investments/view_models/investments_viewmodel.dart';
import '../ui/wallet/view_models/wallet_list_viewmodel.dart';

List<SingleChildWidget> get providers {
  return <SingleChildWidget>[
    // Repositories
    Provider<InvestmentRepository>(create: (BuildContext context) => InvestmentRepositoryImpl()),
    Provider<AccountBalanceRepository>(
      create: (BuildContext context) => AccountBalanceRepositoryImpl(),
    ),
    Provider<InvestmentCategoryRepository>(
      create: (BuildContext context) => InvestmentCategoryRepositoryImpl(),
    ),
    Provider<InvestmentWalletRepository>(
      create: (BuildContext context) => InvestmentWalletRepositoryImpl(),
    ),

    // ViewModels
    ChangeNotifierProvider<InvestmentsViewmodel>(
      create:
          (BuildContext context) => InvestmentsViewmodel(
            investmentCategoryRepository: context.read<InvestmentCategoryRepository>(),
            investmentRepository: context.read<InvestmentRepository>(),
          ),
    ),
    ChangeNotifierProvider<BalanceViewmodel>(
      create:
          (BuildContext context) =>
              BalanceViewmodel(accountBalanceRepository: context.read<AccountBalanceRepository>()),
    ),
    ChangeNotifierProvider<DashboardViewmodel>(
      create:
          (BuildContext context) => DashboardViewmodel(
            investmentRepository: context.read<InvestmentRepository>(),
            accountBalanceRepository: context.read<AccountBalanceRepository>(),
          ),
    ),
    ChangeNotifierProvider<InvestmentCategoryViewmodel>(
      create:
          (BuildContext context) => InvestmentCategoryViewmodel(
            investmentCategoryRepository: context.read<InvestmentCategoryRepository>(),
          ),
    ),
    ChangeNotifierProvider<WalletListViewmodel>(
      create:
          (BuildContext context) => WalletListViewmodel(
            investmentWalletRepository: context.read<InvestmentWalletRepository>(),
          ),
    ),
  ];
}

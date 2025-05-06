import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/investment_wallet_option.dart';
import 'investment_model.dart';
import 'investment_wallet_model.dart';

@Entity()
class InvestmentWalletOptionModel {
  InvestmentWalletOptionModel({
    required this.id,
    required this.name,
    required this.walletPercentage,
    required this.value,
  });

  factory InvestmentWalletOptionModel.fromDomain(InvestmentWalletOption option) =>
      InvestmentWalletOptionModel(
          id: option.id,
          name: option.name,
          walletPercentage: option.walletPercentage,
          value: option.value,
        )
        ..investment.target = InvestmentModel.fromDomain(option.investment!)
        ..wallet.target = InvestmentWalletModel.fromDomain(option.wallet);

  @Id()
  int id = 0;
  String name;
  double walletPercentage;
  double value;

  final ToOne<InvestmentWalletModel> wallet = ToOne<InvestmentWalletModel>();
  final ToOne<InvestmentModel> investment = ToOne<InvestmentModel>();

  InvestmentWalletOption toDomain() {
    return InvestmentWalletOption(
      id: id,
      name: name,
      walletPercentage: walletPercentage,
      value: value,
      investment: investment.target?.toDomain(),
      wallet: wallet.target!.toDomain(),
    );
  }
}

import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/investment_wallet.dart';
import '../../../domain/entities/investment_wallet_option.dart';
import 'investment_wallet_option_model.dart';

@Entity()
class InvestmentWalletModel {

  InvestmentWalletModel({required this.id, required this.name, required this.valueToInvest});

  factory InvestmentWalletModel.fromDomain(InvestmentWallet wallet) =>
      InvestmentWalletModel(id: wallet.id, name: wallet.name, valueToInvest: wallet.valueToInvest)
        ..options.addAll(
          wallet.options.map((InvestmentWalletOption option) => InvestmentWalletOptionModel.fromDomain(option)).toList(),
        );
        
  @Id()
  int id = 0;
  String name;
  double valueToInvest;

  final ToMany<InvestmentWalletOptionModel> options = ToMany<InvestmentWalletOptionModel>();

  InvestmentWallet toDomain() {
    return InvestmentWallet(id: id, name: name, valueToInvest: valueToInvest)
      ..options.addAll(options.map((InvestmentWalletOptionModel option) => option.toDomain()).toList());
  }
}

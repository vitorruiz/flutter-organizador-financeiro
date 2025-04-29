import 'package:hive/hive.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';

part 'account_balance_model.g.dart';

@HiveType(typeId: 2)
class AccountBalanceModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double balance;

  AccountBalanceModel({required this.id, required this.name, required this.balance});

  AccountBalance toDomain() {
    return AccountBalance(id: id, name: name, balance: balance);
  }

  factory AccountBalanceModel.fromDomain(AccountBalance account) => AccountBalanceModel(id: account.id, name: account.name, balance: account.balance);
}

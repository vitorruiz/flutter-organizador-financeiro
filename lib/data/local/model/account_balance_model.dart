import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountBalanceModel {
  @Id()
  int id = 0;

  String name;
  double balance;

  AccountBalanceModel({required this.id, required this.name, required this.balance});

  AccountBalance toDomain() {
    return AccountBalance(id: id, name: name, balance: balance);
  }

  factory AccountBalanceModel.fromDomain(AccountBalance account) => AccountBalanceModel(id: account.id, name: account.name, balance: account.balance);
}

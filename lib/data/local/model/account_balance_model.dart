import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/account_balance.dart';

@Entity()
class AccountBalanceModel {

  AccountBalanceModel({required this.id, required this.name, required this.balance});

  factory AccountBalanceModel.fromDomain(AccountBalance account) =>
      AccountBalanceModel(id: account.id, name: account.name, balance: account.balance);
      
  @Id()
  int id = 0;
  String name;
  double balance;

  AccountBalance toDomain() {
    return AccountBalance(id: id, name: name, balance: balance);
  }
}

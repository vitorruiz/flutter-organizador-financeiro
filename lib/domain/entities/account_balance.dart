class AccountBalance {
  int id;
  String name;
  double balance;

  AccountBalance({int? id, required this.name, required this.balance}) : id = id ?? 0;
}

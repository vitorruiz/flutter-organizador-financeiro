class AccountBalance {
  static const String tableName = 'accounts';
  static const String paramId = 'id';
  static const String paramName = 'name';
  static const String paramBalance = 'balance';

  String id = "";
  String name;
  double balance;

  AccountBalance({required this.name, required this.balance});

  AccountBalance.fromJson(Map<String, dynamic> json)
      : id = json[paramId],
        name = json[paramName],
        balance = json[paramBalance];

  Map<String, dynamic> toJson() => {
        paramId: id,
        paramName: name,
        paramBalance: balance,
      };
}

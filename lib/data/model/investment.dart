class Investment {
  static const String tableName = 'investments';
  static const String paramId = 'id';
  static const String paramName = 'name';
  static const String paramPrice = 'price';
  static const String paramAveragePrice = 'average_price';
  static const String paramQuantity = 'quantity';
  static const String paramBalance = 'balance';
  static const String paramGoalId = 'goal_id';

  String id = "";
  String name;
  double? price;
  double averagePrice;
  double quantity;
  double? _balance;
  String? goalId;

  Investment({
    required this.name,
    required this.quantity,
    required this.averagePrice,
    this.goalId,
    this.price,
    double? balance,
  }) {
    _balance = balance;
  }

  Investment.fromJson(Map<String, dynamic> json)
      : id = json[paramId],
        goalId = json[paramGoalId],
        name = json[paramName],
        price = json[paramPrice],
        averagePrice = json[paramAveragePrice],
        quantity = json[paramQuantity],
        _balance = json[paramBalance];

  Map<String, dynamic> toJson() => {
        paramId: id,
        paramName: name,
        paramPrice: price,
        paramAveragePrice: averagePrice,
        paramQuantity: quantity,
        paramBalance: _balance,
        paramGoalId: goalId
      };

  void setBalance(double balance) {
    _balance = balance;
  }

  double amount() {
    return averagePrice * quantity;
  }

  double balance() {
    var balance = _balance;
    var price = this.price ?? averagePrice;

    if (balance != null) {
      return balance;
    }
    return price * quantity;
  }

  double rentability() {
    return (balance() / amount()) - 1;
  }

  String formattedRentability() {
    return "${(rentability() * 100).toStringAsFixed(2)}%";
  }
}

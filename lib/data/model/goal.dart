import 'package:meu_patrimonio/data/model/investment.dart';

class Goal {
  static const String tableName = 'goals';
  static const String paramId = 'id';
  static const String paramName = 'name';

  String id = "";
  String name;
  List<Investment> investments = [];

  Goal({required this.name});

  Goal.fromJson(Map<String, dynamic> json)
      : id = json[paramId],
        name = json[paramName];

  Map<String, dynamic> toJson() => {
        paramId: id,
        paramName: name,
      };

  double balance() {
    double sum = 0;
    for (var e in investments) {
      sum += e.balance();
    }
    return sum;
  }

  double amount() {
    double amount = 0;
    for (var e in investments) {
      amount += e.amount();
    }
    return amount;
  }

  double rentability() {
    return (balance() / amount()) - 1;
  }

  String formattedRentability() {
    return "${(rentability() * 100).toStringAsFixed(2)}%";
  }
}

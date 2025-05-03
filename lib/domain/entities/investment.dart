import 'package:meu_patrimonio/domain/entities/investment_category.dart';

class Investment {
  int id;
  String name;
  double price;
  double averagePrice;
  double quantity;
  InvestmentCategory category;

  Investment({int? id, required this.name, required this.price, required this.averagePrice, required this.quantity, required this.category})
    : id = id ?? 0;

  double amount() {
    return averagePrice * quantity;
  }

  double balance() {
    return price * quantity;
  }

  double rentability() {
    return (balance() / amount()) - 1;
  }

  String formattedRentability() {
    return "${(rentability() * 100).toStringAsFixed(2)}%";
  }
}

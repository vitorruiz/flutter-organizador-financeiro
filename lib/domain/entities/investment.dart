import 'package:uuid/uuid.dart';

class Investment {
  String id;
  String name;
  double price;
  double averagePrice;
  double quantity;

  Investment({String? id, required this.name, required this.price, required this.averagePrice, required this.quantity})
    : id = id ?? const Uuid().v4();

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

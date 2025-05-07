import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/investment.dart';

@Entity()
class InvestmentModel {

  InvestmentModel({
    required this.id,
    required this.name,
    required this.price,
    required this.averagePrice,
    required this.quantity,
    required this.updatedAt,
  });

  factory InvestmentModel.fromDomain(Investment investment) => InvestmentModel(
    id: investment.id,
    name: investment.name,
    averagePrice: investment.averagePrice,
    price: investment.price,
    quantity: investment.quantity,
    updatedAt: investment.updatedAt,
  );
  
  @Id()
  int id = 0;
  String name;
  double price;
  double averagePrice;
  double quantity;
  int updatedAt = DateTime.now().millisecondsSinceEpoch;

  Investment toDomain() {
    return Investment(
      id: id,
      name: name,
      averagePrice: averagePrice,
      price: price,
      quantity: quantity,
      updatedAt: updatedAt,
    );
  }
}

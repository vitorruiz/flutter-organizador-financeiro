import 'package:hive/hive.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';

part 'investment_model.g.dart';

@HiveType(typeId: 1)
class InvestmentModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double price;
  @HiveField(3)
  double averagePrice;
  @HiveField(4)
  double quantity;

  InvestmentModel({required this.id, required this.name, required this.price, required this.averagePrice, required this.quantity});

  Investment toDomain() {
    return Investment(id: id, name: name, averagePrice: averagePrice, price: price, quantity: quantity);
  }

  factory InvestmentModel.fromDomain(Investment investment) => InvestmentModel(
    id: investment.id,
    name: investment.name,
    averagePrice: investment.averagePrice,
    price: investment.price,
    quantity: investment.quantity,
  );
}

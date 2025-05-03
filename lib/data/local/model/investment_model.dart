import 'package:meu_patrimonio/data/local/model/investment_category_model.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InvestmentModel {
  @Id()
  int id = 0;

  String name;

  double price;

  double averagePrice;

  double quantity;

  final category = ToOne<InvestmentCategoryModel>();

  InvestmentModel({
    required this.id,
    required this.name,
    required this.price,
    required this.averagePrice,
    required this.quantity,
  });

  Investment toDomain(InvestmentCategory category) {
    return Investment(id: id, name: name, averagePrice: averagePrice, price: price, quantity: quantity, category: category);
  }

  factory InvestmentModel.fromDomain(Investment investment) => InvestmentModel(
    id: investment.id,
    name: investment.name,
    averagePrice: investment.averagePrice,
    price: investment.price,
    quantity: investment.quantity,
  )..category.target = InvestmentCategoryModel.fromDomain(investment.category);
}

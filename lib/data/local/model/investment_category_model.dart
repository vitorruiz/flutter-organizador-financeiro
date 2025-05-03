
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InvestmentCategoryModel {
  @Id()
  int id = 0;

  String name;

  InvestmentCategoryModel({required this.id, required this.name});

  factory InvestmentCategoryModel.fromDomain(InvestmentCategory cat) {
    return InvestmentCategoryModel(id: cat.id, name: cat.name);
  }

  InvestmentCategory toDomain() {
    return InvestmentCategory(id: id, name: name);
  }
}

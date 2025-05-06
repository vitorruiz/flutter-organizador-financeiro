import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/investment_category.dart';

@Entity()
class InvestmentCategoryModel {

  InvestmentCategoryModel({required this.id, required this.name});

  factory InvestmentCategoryModel.fromDomain(InvestmentCategory cat) {
    return InvestmentCategoryModel(id: cat.id, name: cat.name);
  }
  
  @Id()
  int id = 0;
  String name;

  InvestmentCategory toDomain() {
    return InvestmentCategory(id: id, name: name);
  }
}

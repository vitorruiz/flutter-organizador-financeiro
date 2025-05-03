import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:uuid/uuid.dart';

class InvestmentWallet {
  String id;
  String name;
  List<Investment> investments = [];

  InvestmentWallet({String? id, required this.name}) : id = id ?? const Uuid().v4();
}
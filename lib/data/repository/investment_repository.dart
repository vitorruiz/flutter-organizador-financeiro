import 'package:meu_patrimonio/data/db/dao/investment_dao.dart';
import 'package:meu_patrimonio/data/model/investment.dart';

class InvestmentRepository {
  final _investmentDao = InvestmentDao();

  Future<List<Investment>> getInvestments() {
    return _investmentDao.findAll();
  }

  Future<int> createInvestment({
    required String name,
    required double averagePrice,
    required double quantity,
    double? price,
    double? balance,
  }) async {
    return _investmentDao.save(Investment(
      name: name,
      quantity: quantity,
      averagePrice: averagePrice,
      price: price != 0 ? price : null,
      balance: balance != 0 ? balance : null,
    ));
  }

  Future<int> updateInvestment({
    required String id,
    required double averagePrice,
    required double quantity,
    double? price,
    double? balance,
  }) async {
    final investment = await _investmentDao.find(id);
    investment.averagePrice = averagePrice;
    investment.quantity = quantity;
    investment.price = price;
    return _investmentDao.save(investment);
  }

  Future<int> delete(String id) async {
    return _investmentDao.delete(id);
  }
}

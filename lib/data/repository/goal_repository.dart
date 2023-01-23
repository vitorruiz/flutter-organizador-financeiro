import 'package:meu_patrimonio/data/db/dao/goal_dao.dart';
import 'package:meu_patrimonio/data/db/dao/investment_dao.dart';
import 'package:meu_patrimonio/data/model/goal.dart';
import 'package:meu_patrimonio/data/model/investment.dart';

class GoalRepository {
  final _goalDao = GoalDao();
  final _investmentDao = InvestmentDao();

  Future<List<Goal>> getGoals() async {
    final goalList = await _goalDao.findAll();
    for (var goal in goalList) {
      goal.investments = await _investmentDao.findByGoal(goal.id);
    }
    return goalList;
  }

  Future<List<Investment>> getInvestments(String goalId) async {
    return _investmentDao.findByGoal(goalId);
  }

  Future<int> createGoal(String name) async {
    return _goalDao.save(Goal(name: name));
  }

  Future<int> saveGoal(Goal goal) async {
    return _goalDao.save(goal);
  }
}

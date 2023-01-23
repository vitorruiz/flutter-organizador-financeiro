import 'dart:async';

import 'package:meu_patrimonio/data/model/investment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';

class InvestmentDao {
  static const String tableSql = 'CREATE TABLE ${Investment.tableName}('
      '${Investment.paramId} TEXT PRIMARY KEY, '
      '${Investment.paramName} TEXT, '
      '${Investment.paramAveragePrice} REAL, '
      '${Investment.paramBalance} REAL, '
      '${Investment.paramPrice} REAL, '
      '${Investment.paramGoalId} TEXT, '
      '${Investment.paramQuantity} REAL)';

  Future<int> save(Investment investment) async {
    final Database db = await getDatabase();
    if (investment.id.isEmpty) {
      investment.id = const Uuid().v1();
    }
    Map<String, dynamic> investmentMap = investment.toJson();
    return db.insert(Investment.tableName, investmentMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Investment>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(Investment.tableName);
    return result.map((e) => Investment.fromJson(e)).toList();
  }

  Future<List<Investment>> findByGoal(String goalId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(Investment.tableName, where: "${Investment.paramGoalId} = '$goalId'");
    return result.map((e) => Investment.fromJson(e)).toList();
  }

  Future<Investment> find(String id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(Investment.tableName, where: "${Investment.paramId} = '$id'");
    return result.map((e) => Investment.fromJson(e)).single;
  }

  Future<int> delete(String id) async {
    final Database db = await getDatabase();
    return db.delete(Investment.tableName, where: "${Investment.paramId} = '$id'");
  }
}

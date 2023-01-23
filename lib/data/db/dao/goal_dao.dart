import 'dart:async';

import 'package:meu_patrimonio/data/db/app_database.dart';
import 'package:meu_patrimonio/data/model/goal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class GoalDao {
  static const String tableSql = 'CREATE TABLE ${Goal.tableName}('
      '${Goal.paramId} TEXT PRIMARY KEY, '
      '${Goal.paramName} TEXT)';

  Future<int> save(Goal goal) async {
    final Database db = await getDatabase();
    if (goal.id.isEmpty) {
      goal.id = const Uuid().v1();
    }
    Map<String, dynamic> goalMap = goal.toJson();
    return db.insert(Goal.tableName, goalMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Goal>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(Goal.tableName);
    return result.map((e) => Goal.fromJson(e)).toList();
  }

  Future<Goal> find(String id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(Goal.tableName, where: "${Goal.paramId} = $id");
    return result.map((e) => Goal.fromJson(e)).single;
  }
}

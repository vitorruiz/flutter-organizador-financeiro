import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../model/account_balance.dart';
import '../app_database.dart';

class AccountBalanceDao {
  static const String tableSql = 'CREATE TABLE ${AccountBalance.tableName}('
      '${AccountBalance.paramId} TEXT PRIMARY KEY, '
      '${AccountBalance.paramBalance} REAL, '
      '${AccountBalance.paramName} TEXT)';

  Future<int> save(AccountBalance account) async {
    final Database db = await getDatabase();
    if (account.id.isEmpty) {
      account.id = const Uuid().v1();
    }
    Map<String, dynamic> map = account.toJson();
    return db.insert(AccountBalance.tableName, map, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<AccountBalance>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(AccountBalance.tableName);
    return result.map((e) => AccountBalance.fromJson(e)).toList();
  }

  Future<AccountBalance> find(String id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(AccountBalance.tableName, where: "${AccountBalance.paramId} = '$id'");
    return result.map((e) => AccountBalance.fromJson(e)).single;
  }

  Future<int> delete(String id) async {
    final Database db = await getDatabase();
    return db.delete(AccountBalance.tableName, where: "${AccountBalance.paramId} = '$id'");
  }
}

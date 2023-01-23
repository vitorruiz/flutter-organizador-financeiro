import 'package:meu_patrimonio/data/db/dao/account_balance_dao.dart';
import 'package:meu_patrimonio/data/db//dao/goal_dao.dart';
import 'package:meu_patrimonio/data/db/dao/investment_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const int _dbVersion = 1;

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "db_$_dbVersion.db"),
    onCreate: (db, version) {
      db.execute(GoalDao.tableSql);
      db.execute(InvestmentDao.tableSql);
      db.execute(AccountBalanceDao.tableSql);
    },
    onOpen: (db) {

    },
    version: _dbVersion,
  );
}
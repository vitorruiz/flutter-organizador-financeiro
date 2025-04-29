import 'package:uuid/uuid.dart';

class AccountBalance {
  String id;
  String name;
  double balance;

  AccountBalance({String? id, required this.name, required this.balance}) : id = id ?? const Uuid().v4();
}

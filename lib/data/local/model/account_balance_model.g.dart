// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountBalanceModelAdapter extends TypeAdapter<AccountBalanceModel> {
  @override
  final int typeId = 2;

  @override
  AccountBalanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountBalanceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      balance: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AccountBalanceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountBalanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvestmentModelAdapter extends TypeAdapter<InvestmentModel> {
  @override
  final int typeId = 1;

  @override
  InvestmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvestmentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as double,
      averagePrice: fields[3] as double,
      quantity: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InvestmentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.averagePrice)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 1;

  @override
  Categories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categories(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BirthdaysAdapter extends TypeAdapter<Birthdays> {
  @override
  final int typeId = 2;

  @override
  Birthdays read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Birthdays(
      name: fields[0] as String?,
      number: fields[2] as String?,
      date: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Birthdays obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirthdaysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 3;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      name: fields[0] as String?,
      number: fields[2] as String?,
      dailyReminderHour: fields[4] as int?,
      image: fields[3] as String?,
      language: fields[1] as String?,
      selectedColorAlpha: fields[5] as int?,
      selectedColorBlue: fields[7] as int?,
      selectedColorGreen: fields[6] as int?,
      selectedColorRed: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.dailyReminderHour)
      ..writeByte(5)
      ..write(obj.selectedColorAlpha)
      ..writeByte(6)
      ..write(obj.selectedColorGreen)
      ..writeByte(7)
      ..write(obj.selectedColorBlue)
      ..writeByte(8)
      ..write(obj.selectedColorRed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksAdapter extends TypeAdapter<Tasks> {
  @override
  final int typeId = 0;

  @override
  Tasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tasks(
      category: fields[4] as String?,
      colorAlpha: fields[3] as int?,
      day: fields[6] as int?,
      description: fields[2] as String?,
      done: fields[5] as bool?,
      hour: fields[9] as int?,
      id: fields[0] as String?,
      minute: fields[10] as int?,
      month: fields[7] as int?,
      title: fields[1] as String?,
      weekDay: fields[11] as int?,
      year: fields[8] as int?,
      colorRed: fields[12] as int?,
      colorBlue: fields[14] as int?,
      colorGreen: fields[13] as int?,
      image: fields[15] as String?,
      voice: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Tasks obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.colorAlpha)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.done)
      ..writeByte(6)
      ..write(obj.day)
      ..writeByte(7)
      ..write(obj.month)
      ..writeByte(8)
      ..write(obj.year)
      ..writeByte(9)
      ..write(obj.hour)
      ..writeByte(10)
      ..write(obj.minute)
      ..writeByte(11)
      ..write(obj.weekDay)
      ..writeByte(12)
      ..write(obj.colorRed)
      ..writeByte(13)
      ..write(obj.colorGreen)
      ..writeByte(14)
      ..write(obj.colorBlue)
      ..writeByte(15)
      ..write(obj.image)
      ..writeByte(16)
      ..write(obj.voice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      dateTime: fields[1] as DateTime?,
      dailyReminderHour: fields[4] as int?,
      image: fields[3] as String?,
      language: fields[5] as String?,
      selectedColor: fields[6] as Color?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.dailyReminderHour)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.selectedColor);
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

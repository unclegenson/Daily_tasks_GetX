import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'hive_models.g.dart';

@HiveType(typeId: 0)
class Tasks {
  Tasks({
    required this.category,
    required this.colorAlpha,
    required this.day,
    required this.description,
    required this.done,
    required this.hour,
    required this.id,
    required this.minute,
    required this.month,
    required this.title,
    required this.weekDay,
    required this.year,
    required this.colorRed,
    required this.colorBlue,
    required this.colorGreen,
    required this.image,
    required this.voice,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? colorAlpha;
  @HiveField(4)
  String? category;
  @HiveField(5)
  bool? done;

  // time
  @HiveField(6)
  int? day;
  @HiveField(7)
  int? month;
  @HiveField(8)
  int? year;
  @HiveField(9)
  int? hour;
  @HiveField(10)
  int? minute;
  @HiveField(11)
  int? weekDay;
  @HiveField(12)
  int? colorRed;
  @HiveField(13)
  int? colorGreen;
  @HiveField(14)
  int? colorBlue;
  @HiveField(15)
  String? image;
  @HiveField(16)
  String? voice;
}

@HiveType(typeId: 1)
class Categories {
  Categories({
    required this.name,
  });

  @HiveField(0)
  String? name;
}

@HiveType(typeId: 2)
class Birthdays {
  Birthdays({
    required this.name,
    required this.number,
    required this.date,
  });
  @HiveField(0)
  String? name;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  String? number;
}

@HiveType(typeId: 3)
class UserInfo {
  UserInfo({
    required this.name,
    required this.number,
    required this.dateTime,
    required this.dailyReminderHour,
    required this.image,
    required this.language,
    required this.selectedColor,
  });
  @HiveField(0)
  String? name;

  @HiveField(1)
  DateTime? dateTime;

  @HiveField(2)
  String? number;

  @HiveField(3)
  String? image;

  @HiveField(4)
  int? dailyReminderHour;

  @HiveField(5)
  String? language;

  @HiveField(6)
  Color? selectedColor;
}

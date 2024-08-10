import 'package:hive/hive.dart';

part 'hive_models.g.dart';

@HiveType(typeId: 3)
class UserInfo {
  UserInfo({
    required this.name,
    required this.number,
    required this.dailyReminderHour,
    required this.image,
    required this.language,
    required this.selectedColorAlpha,
    required this.selectedColorBlue,
    required this.selectedColorGreen,
    required this.selectedColorRed,
  });
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? language;

  @HiveField(2)
  String? number;

  @HiveField(3)
  String? image;

  @HiveField(4)
  int? dailyReminderHour;

  @HiveField(5)
  int? selectedColorAlpha;

  @HiveField(6)
  int? selectedColorGreen;

  @HiveField(7)
  int? selectedColorBlue;

  @HiveField(8)
  int? selectedColorRed;

  @HiveField(9)
  int? dailyReminderMinute;
}

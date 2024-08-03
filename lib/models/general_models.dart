class TasksModel {
  TasksModel({
    required this.category,
    required this.colorAlpha,
    required this.day,
    required this.description,
    required this.done,
    required this.hour,
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

  String? title;
  String? description;
  int? colorAlpha;
  String? category;
  bool? done;
  int? day;
  int? month;
  int? year;
  int? hour;
  int? minute;
  int? weekDay;
  int? colorRed;
  int? colorGreen;
  int? colorBlue;
  String? image;
  String? voice;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'colorAlpha': colorAlpha,
      'category': category,
      'done': done,
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'minute': minute,
      'weekDay': weekDay,
      'colorRed': colorRed,
      'colorGreen': colorGreen,
      'colorBlue': colorBlue,
      'image': image,
      'voice': voice,
    };
  }

  TasksModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        colorAlpha = json['colorAlpha'],
        category = json['category'],
        done = json['done'],
        day = json['day'],
        month = json['month'],
        year = json['year'],
        hour = json['hour'],
        minute = json['minute'],
        weekDay = json['weekDay'],
        colorRed = json['colorRed'],
        colorGreen = json['colorGreen'],
        colorBlue = json['colorBlue'],
        image = json['image'],
        voice = json['voice'];
}
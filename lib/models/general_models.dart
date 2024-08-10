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
    required this.audioId,
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
  int? audioId;

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
      'audioId': audioId,
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
        voice = json['voice'],
        audioId = json['audioId'];
}

class CategoriesModel {
  CategoriesModel({
    required this.category,
  });

  String? category;

  Map<String, dynamic> toJson() {
    return {
      'category': category,
    };
  }

  CategoriesModel.fromJson(Map<String, dynamic> json)
      : category = json['category'];
}

class BirthdayModel {
  BirthdayModel({
    required this.name,
    required this.number,
    required this.day,
    required this.mounth,
    required this.year,
  });

  String? name;
  int? day;
  int? mounth;
  int? year;
  String? number;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'day': day,
      'mounth': mounth,
      'year': year,
      'number': number,
    };
  }

  BirthdayModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        number = json['number'],
        day = json['day'],
        mounth = json['mounth'],
        year = json['year'];
}


class Task {
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat
    };
  }

  Task.fromjson(Map<String, dynamic> json) {
        id = json['id'];
        title= json['title'];
        note= json['note'];
        isCompleted= json['isCompleted'];
        date= json['data'];
        startTime= json['startTime'];
        endTime= json['endTime'];
        color= json['color'];
        remind= json['remind'];
        repeat= json['repeat'];
  }



}

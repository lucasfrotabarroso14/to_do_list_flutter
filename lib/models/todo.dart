class ToDo {
  
  ToDo.fromJson(Map<String, dynamic> json) //construtor nomeado
      : title = json['title'],
        dateTime = DateTime.parse(json['datetime']);

  ToDo({required this.title, required this.dateTime});

  String title;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime.toIso8601String(),
    };
  }
}

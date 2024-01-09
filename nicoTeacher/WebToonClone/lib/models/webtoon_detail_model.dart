class WebtoonDetailMode {
  final String title, about, genre, age;

  WebtoonDetailMode.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}

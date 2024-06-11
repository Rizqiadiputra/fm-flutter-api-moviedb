class Movie {
  final String title;

  Movie({required this.title});

  factory Movie.fromJson(Map<String, dynamic>json){
    return Movie(
      title: json['title'] ?? json['name'] ?? 'No Title',
    );
  }
}
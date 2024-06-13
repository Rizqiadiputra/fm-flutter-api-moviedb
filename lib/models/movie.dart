class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final double rating;
  final String releaseDate;

  Movie({
    required this.title,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.posterPath
  });

  factory Movie.fromJson(Map<String, dynamic>json){
    return Movie(
      title: json['title'] ?? json['name'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      rating: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? 'No Release Date',
      posterPath: json['poster_path'] ?? '',
    );
  }
}
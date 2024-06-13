import 'package:flutter/material.dart';
import 'package:movie_db_flutter/models/movie.dart';
import 'package:movie_db_flutter/movie_detail.dart';

class MovieCard extends StatelessWidget{
  const MovieCard({Key? key, required this.movies}):super(key: key);
  final Movie movies;

  @override
  Widget build(BuildContext context){
    return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context){
                return DetailMovie(movies: movies);
              }),
            ),
          );
        },
      // Menampilkan judul film dan gambar poster dalam kartu.
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movies.posterPath}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movies.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
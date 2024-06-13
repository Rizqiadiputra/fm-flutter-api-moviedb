import 'package:flutter/material.dart';
import 'package:movie_db_flutter/models/movie.dart';

//Menampilkan detail film saat kartu diklik.
class DetailMovie extends StatelessWidget {
  final Movie movies;
  const DetailMovie({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
        ),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movies.posterPath.isNotEmpty
                    ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movies.posterPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      )
                    : Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Title: ${movies.title}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
}
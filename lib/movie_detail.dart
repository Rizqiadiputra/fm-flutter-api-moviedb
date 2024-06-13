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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Overview: ${movies.overview}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child:
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Release Date: ${movies.releaseDate}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        child: Row(
                          children: [
                            const Text(
                              'Rating:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movies.rating} / 10 ',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      ),

                    ],
                  )
                ),

                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Text(
                  //     'Related Movies',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Expanded(
                  //     child: ListView.builder(
                  //         itemCount: 10,
                  //         itemBuilder: (context, index){
                  //           return ListTile(
                  //             title: Text('Item ${index + 1}'),
                  //             onTap: () {
                  //               // Tambahkan navigasi atau aksi lainnya
                  //             },
                  //           );
                  //         },
                  //     ),
                  // ),
              ],
            ),
          ),
        );
    }
}
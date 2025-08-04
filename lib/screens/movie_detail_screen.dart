import 'package:flutter/material.dart';
import '../models/movies.dart';
import '../services/api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbID;
  const MovieDetailScreen({super.key, required this.imdbID});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = ApiService().fetchMovieDetail(widget.imdbID);
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<MovieDetail>(
        future: _detailFuture,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final m = snap.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    m.posterUrl,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                const SizedBox(height: 16),
                Text('${m.title} (${m.year})',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Rated: ${m.rated}'),
                Text('Released: ${m.released}'),
                Text('Runtime: ${m.runtime}'),
                Text('Genre: ${m.genre}'),
                const SizedBox(height: 8),
                Text('Director: ${m.director}'),
                Text('Writer: ${m.writer}'),
                Text('Actors: ${m.actors}'),
                const SizedBox(height: 12),
                Text('Plot:', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(m.plot),
                const SizedBox(height: 12),
                Text('Language: ${m.language}'),
                Text('Country: ${m.country}'),
                Text('Awards: ${m.awards}'),
                const SizedBox(height: 12),
                Text('IMDB Rating: ${m.imdbRating}'),
                Text('Metascore: ${m.metascore}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

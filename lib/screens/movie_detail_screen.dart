// movie_detail_screen.dart
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
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
                  child: Hero(
                    tag: 'poster-${m.imdbID}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        m.posterUrl,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 300,
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '${m.title} (${m.year})',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildDetailChip('Rated: ${m.rated}'),
                    _buildDetailChip('Runtime: ${m.runtime}'),
                    _buildDetailChip('IMDB: ${m.imdbRating}'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Plot Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  m.plot,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                _buildInfoSection('Director', m.director),
                _buildInfoSection('Writer', m.writer),
                _buildInfoSection('Actors', m.actors),
                _buildInfoSection('Genre', m.genre),
                _buildInfoSection('Language', m.language),
                _buildInfoSection('Country', m.country),
                _buildInfoSection('Awards', m.awards),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildDetailChip(String text) {
    return Chip(
      backgroundColor: Colors.cyan.withOpacity(0.2),
      label: Text(
        text,
        style: const TextStyle(color: Colors.cyan),
      ),
    );
  }
  
  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
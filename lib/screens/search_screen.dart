import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movies.dart';
import '../providers/watchlist_provider.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _api = ApiService();
  List<Movie> _results = [];
  bool _loading = false;
  String? _error;

  Future<void> _search(String term) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await _api.searchMovies(term);
      setState(() => _results = list);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlist = context.read<WatchlistProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Search movies'),
            onSubmitted: _search,
          ),
        ),
        if (_loading) const LinearProgressIndicator(),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (_, i) {
              final m = _results[i];
              return ListTile(
                leading: Image.network(
                  m.posterUrl,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
                title: Text(m.title),
                subtitle: Text(m.year),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => watchlist.add(m),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

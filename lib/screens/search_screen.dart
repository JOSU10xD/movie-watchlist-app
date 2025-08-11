import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movies.dart';
import '../providers/watchlist_provider.dart';
import '../services/api_service.dart';
import '../screens/movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _api = ApiService();
  final _controller = TextEditingController();
  final _focusNode  = FocusNode();
  List<Movie> _results = [];
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _search(String term) async {
    // don't clear the controller here!
    _focusNode.unfocus();
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
    // re-focus the field so keyboard events work
  }

  @override
  Widget build(BuildContext context) {
  final watchlist = context.read<WatchlistProvider>();
  return SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: false, // ❌ no auto popup
            decoration: const InputDecoration(labelText: 'Search movies'),
            textInputAction: TextInputAction.search,
            onSubmitted: (term) => _search(term),
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
                onTap: () {
                  _focusNode.unfocus(); // ✅ also hide keyboard when navigating
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(imdbID: m.imdbID),
                    ),
                  );
                },
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
    )
  );
  }
}

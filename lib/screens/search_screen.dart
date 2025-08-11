import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movies.dart';
import '../providers/watchlist_provider.dart';
import '../services/api_service.dart';
import '../screens/movie_detail_screen.dart';
import '../widgets/movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _api = ApiService();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
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
    if (term.isEmpty) return;
    
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
  }
  
  @override
  Widget build(BuildContext context) {
    final watchlist = context.read<WatchlistProvider>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: 'Search movies...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _focusNode.unfocus();
                  setState(() => _results = []);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: _search,
          ),
          const SizedBox(height: 16),
          if (_loading) const LinearProgressIndicator(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: _results.isEmpty && !_loading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_creation,
                          size: 80,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Search for movies',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (_, i) {
                      final m = _results[i];
                      return MovieItem(
                        movie: m,
                        onTap: () {
                          _focusNode.unfocus();
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => MovieDetailScreen(imdbID: m.imdbID),
                              transitionsBuilder: (_, animation, __, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.add, color: Colors.cyan),
                          onPressed: () => watchlist.add(m),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
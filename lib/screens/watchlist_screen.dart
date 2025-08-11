// watchlist_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';
import '../screens/movie_detail_screen.dart';
import '../widgets/movie_item.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final wl = context.watch<WatchlistProvider>().watchlist;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: wl.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your watchlist is empty',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text('Search movies and add them to your list'),
                ],
              ),
            )
          : ReorderableListView.builder(
              itemCount: wl.length,
              onReorder: context.read<WatchlistProvider>().reorder,
              itemBuilder: (_, i) {
                final m = wl[i];
                return Dismissible(
                  key: ValueKey(m.imdbID),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => context.read<WatchlistProvider>().removeAt(i),
                  child: MovieItem(
                    key: ValueKey(m.imdbID),
                    movie: m,
                    onTap: () => Navigator.push(
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
                    ),
                    trailing: const Icon(Icons.drag_handle, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}
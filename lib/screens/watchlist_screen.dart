import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wl = context.watch<WatchlistProvider>().watchlist;
    return ReorderableListView.builder(
      itemCount: wl.length,
      onReorder: context.read<WatchlistProvider>().reorder,
      itemBuilder: (_, i) {
        final m = wl[i];
        return Dismissible(
          key: ValueKey(m.imdbID),
          onDismissed: (_) => context.read<WatchlistProvider>().removeAt(i),
          child: ListTile(
            leading: Image.network(
              m.posterUrl,
              width: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
            title: Text(m.title),
            subtitle: Text(m.year),
            trailing: const Icon(Icons.drag_handle),
          ),
        );
      },
    );
  }
}

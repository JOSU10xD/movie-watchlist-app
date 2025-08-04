import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movies.dart';

class WatchlistProvider extends ChangeNotifier {
  final List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  WatchlistProvider() {
    _load();
  }

  void add(Movie m) {
    if (!_watchlist.any((e) => e.imdbID == m.imdbID)) {
      _watchlist.add(m);
      _save();
      notifyListeners();
    }
  }

  void removeAt(int index) {
    _watchlist.removeAt(index);
    _save();
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    final item = _watchlist.removeAt(oldIndex);
    _watchlist.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
    _save();
    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('watchlist');
    if (jsonStr != null) {
      final List list = json.decode(jsonStr);
      _watchlist.addAll(list.map((j) => Movie.fromJson(j)).toList());
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final str = json.encode(_watchlist.map((m) => m.toJson()).toList());
    await prefs.setString('watchlist', str);
  }
}

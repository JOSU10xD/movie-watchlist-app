import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/watchlist_provider.dart';
import 'screens/search_screen.dart';
import 'screens/watchlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WatchlistProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CineList',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: Colors.cyan,
            secondary: Colors.cyanAccent,
            surface: const Color(0xFF1E1E1E),
            background: const Color(0xFF121212),
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF1E1E1E),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.cyan),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
          ),
          cardTheme: CardTheme(
            color: const Color(0xFF1E1E1E),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(8),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color(0xFF1E1E1E),
            selectedItemColor: Colors.cyan,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  
  @override
  void initState() {
    super.initState();
    _pages = [
      const SearchScreen(),
      const WatchlistScreen(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Search Movies' : 'My Watchlist'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Watchlist',
          ),
        ],
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}
import '/pages/kanji_page.dart';
import 'package:flutter/material.dart';
import 'pages/entry_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Structured Content Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Entry'),
            Tab(text: 'Kanji'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          EntryPage(),
          KanjiPage(),
        ],
      ),
    );
  }
}

